package portfolio

import (
	"context"
	"errors"
	"time"

	"github.com/jatinfoujdar/Blog-App/internal/auth/model"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
)

type Repository struct {
	Trades       *mongo.Collection
	Users        *mongo.Collection
}

func NewRepository(db *mongo.Database) *Repository {
	return &Repository{
		Trades: db.Collection("trades"),
		Users:  db.Collection("users"),
	}
}

func (r *Repository) GetUserBalance(email string) (float64, error) {
	var user model.User
	err := r.Users.FindOne(context.Background(), bson.M{"email": email}).Decode(&user)
	if err != nil {
		return 0, err
	}
	return user.Balance, nil
}

func (r *Repository) UpdateBalance(email string, amount float64) error {
	_, err := r.Users.UpdateOne(
		context.Background(),
		bson.M{"email": email},
		bson.M{"$inc": bson.M{"balance": amount}},
	)
	return err
}

func (r *Repository) RecordTrade(trade *Trade) error {
	trade.Timestamp = time.Now()
	_, err := r.Trades.InsertOne(context.Background(), trade)
	return err
}

func (r *Repository) GetHoldings(email string) ([]Holding, error) {
	pipeline := mongo.Pipeline{
		{{Key: "$match", Value: bson.M{"userEmail": email}}},
		{{Key: "$group", Value: bson.M{
			"_id": "$stockName",
			"totalQuantity": bson.M{"$sum": bson.M{
				"$cond": bson.A{bson.M{"$eq": bson.A{"$type", "buy"}}, "$quantity", bson.M{"$multiply": bson.A{"$quantity", -1}}},
			}},
			"totalCost": bson.M{"$sum": bson.M{
				"$cond": bson.A{bson.M{"$eq": bson.A{"$type", "buy"}}, "$totalAmount", 0},
			}},
			"totalBuyQuantity": bson.M{"$sum": bson.M{
				"$cond": bson.A{bson.M{"$eq": bson.A{"$type", "buy"}}, "$quantity", 0},
			}},
		}}},
	}

	cursor, err := r.Trades.Aggregate(context.Background(), pipeline)
	if err != nil {
		return nil, err
	}
	defer cursor.Close(context.Background())

	var holdings []Holding
	for cursor.Next(context.Background()) {
		var result struct {
			ID               string  `bson:"_id"`
			TotalQuantity    int     `bson:"totalQuantity"`
			TotalCost        float64 `bson:"totalCost"`
			TotalBuyQuantity int     `bson:"totalBuyQuantity"`
		}
		if err := cursor.Decode(&result); err != nil {
			return nil, err
		}

		if result.TotalQuantity > 0 {
			avgPrice := 0.0
			if result.TotalBuyQuantity > 0 {
				avgPrice = result.TotalCost / float64(result.TotalBuyQuantity)
			}
			holdings = append(holdings, Holding{
				StockName:    result.ID,
				Quantity:     result.TotalQuantity,
				AveragePrice: avgPrice,
			})
		}
	}
	return holdings, nil
}

func (r *Repository) ExecuteTrade(email string, trade *Trade) error {
	// KYC Guard
	var user model.User
	err := r.Users.FindOne(context.Background(), bson.M{"email": email}).Decode(&user)
	if err != nil {
		return err
	}
	if user.KYCStatus != "verified" {
		return errors.New("KYC verification required for trading")
	}

	// Simple transaction-like logic
	if trade.Type == Buy {
		balance, err := r.GetUserBalance(email)
		if err != nil {
			return err
		}
		if balance < trade.TotalAmount {
			return errors.New("insufficient balance")
		}
		if err := r.UpdateBalance(email, -trade.TotalAmount); err != nil {
			return err
		}
	} else if trade.Type == Sell {
		holdings, err := r.GetHoldings(email)
		if err != nil {
			return err
		}
		found := false
		for _, h := range holdings {
			if h.StockName == trade.StockName {
				if h.Quantity < trade.Quantity {
					return errors.New("insufficient stock quantity")
				}
				found = true
				break
			}
		}
		if !found {
			return errors.New("stock not found in portfolio")
		}
		if err := r.UpdateBalance(email, trade.TotalAmount); err != nil {
			return err
		}
	}

	return r.RecordTrade(trade)
}
