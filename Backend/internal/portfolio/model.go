package portfolio

import (
	"time"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type TradeType string

const (
	Buy  TradeType = "buy"
	Sell TradeType = "sell"
)

type Trade struct {
	ID          primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	UserID      primitive.ObjectID `bson:"userId" json:"userId"`
	UserEmail   string             `bson:"userEmail" json:"userEmail"`
	StockName   string             `bson:"stockName" json:"stockName"`
	Type        TradeType          `bson:"type" json:"type"`
	Price       float64            `bson:"price" json:"price"`
	Quantity    int                `bson:"quantity" json:"quantity"`
	TotalAmount float64            `bson:"totalAmount" json:"totalAmount"`
	Timestamp   time.Time          `bson:"timestamp" json:"timestamp"`
}

type Holding struct {
	StockName    string  `bson:"stockName" json:"stockName"`
	Quantity     int     `bson:"quantity" json:"quantity"`
	AveragePrice float64 `bson:"averagePrice" json:"averagePrice"`
}

type Portfolio struct {
	UserEmail string    `json:"userEmail"`
	Holdings  []Holding `json:"holdings"`
	Balance   float64   `json:"balance"`
}
