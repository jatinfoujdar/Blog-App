package kyc

import (
	"context"
	"time"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
)

type Repository struct {
	KYC   *mongo.Collection
	Users *mongo.Collection
}

func NewRepository(db *mongo.Database) *Repository {
	return &Repository{
		KYC:   db.Collection("kyc"),
		Users: db.Collection("users"),
	}
}

func (r *Repository) SubmitKYC(submission *KYCSubmission) error {
	submission.Status = Pending
	submission.SubmittedAt = time.Now()
	_, err := r.KYC.InsertOne(context.Background(), submission)
	if err != nil {
		return err
	}

	_, err = r.Users.UpdateOne(
		context.Background(),
		bson.M{"email": submission.UserEmail},
		bson.M{"$set": bson.M{"kycStatus": string(Pending), "pan": submission.PAN}},
	)
	return err
}

func (r *Repository) GetKYCStatus(email string) (KYCStatus, error) {
	var result struct {
		KYCStatus string `bson:"kycStatus"`
	}
	err := r.Users.FindOne(context.Background(), bson.M{"email": email}).Decode(&result)
	if err != nil {
		return Unverified, err
	}
	return KYCStatus(result.KYCStatus), nil
}

func (r *Repository) VerifyKYC(email string) error {
	_, err := r.Users.UpdateOne(
		context.Background(),
		bson.M{"email": email},
		bson.M{"$set": bson.M{"kycStatus": string(Verified)}},
	)
	if err != nil {
		return err
	}

	_, err = r.KYC.UpdateOne(
		context.Background(),
		bson.M{"userEmail": email},
		bson.M{"$set": bson.M{"status": string(Verified)}},
	)
	return err
}
