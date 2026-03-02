package posts


import (
	"time"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

type Post struct {
	ID          primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	Title       string             `bson:"title" json:"title"`
	Subtitle    string             `bson:"subtitle" json:"subtitle"`
	Content     string             `bson:"content" json:"content"`
	Category    string             `bson:"category" json:"category"`
	AuthorEmail string             `bson:"authorEmail" json:"authorEmail"`
	CreatedAt   time.Time          `bson:"createdAt" json:"createdAt"`
	UpdatedAt   time.Time          `bson:"updatedAt" json:"updatedAt"`
}