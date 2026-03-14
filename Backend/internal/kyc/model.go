package kyc

import (
	"time"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type KYCStatus string

const (
	Unverified KYCStatus = "unverified"
	Pending    KYCStatus = "pending"
	Verified   KYCStatus = "verified"
)

type KYCSubmission struct {
	ID        primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	UserID    primitive.ObjectID `bson:"userId" json:"userId"`
	UserEmail string             `bson:"userEmail" json:"userEmail"`
	PAN       string             `bson:"pan" json:"pan" binding:"required"`
	FullName  string             `bson:"fullName" json:"fullName" binding:"required"`
	Status    KYCStatus          `bson:"status" json:"status"`
	SubmittedAt time.Time        `bson:"submittedAt" json:"submittedAt"`
}
