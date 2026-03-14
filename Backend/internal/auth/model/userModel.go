package model

import (
	"time"

	"go.mongodb.org/mongo-driver/bson/primitive"
)

type User struct {
	ID        primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	Name      string             `bson:"name" json:"name" binding:"required"`
	Email     string             `bson:"email" json:"email" binding:"required,email"`
	Password  string             `bson:"password" json:"password"`
	Role      string             `bson:"role" json:"role"`
	Github    string             `bson:"github" json:"github"`
	Linkedin  string             `bson:"linkedin" json:"linkedin"`
	Twitter   string             `bson:"twitter" json:"twitter"`
	Website   string             `bson:"website" json:"website"`
	Balance   float64            `bson:"balance" json:"balance"`
	KYCStatus string             `bson:"kycStatus" json:"kycStatus"` // unverified, pending, verified
	PAN       string             `bson:"pan" json:"pan"`
	CreatedAt time.Time          `bson:"created_at" json:"created_at"`
	UpdatedAt time.Time          `bson:"updated_at" json:"updated_at"`
}
