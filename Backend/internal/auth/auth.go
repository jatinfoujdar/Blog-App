package auth

import (
	"context"
	"errors"
	"time"

	"github.com/jatinfoujdar/Blog-App/internal/auth/model"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"golang.org/x/crypto/bcrypt"
)


type UserRepository struct {
Collection *mongo.Collection
}


func (r *UserRepository) CreateUser(user *model.User) error {

	var existingUser model.User
	err := r.Collection.FindOne(context.TODO(), bson.M{"email": user.Email}).Decode(&existingUser)
    if err == nil {
      return errors.New("email already exists") 
	}

	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(user.Password), bcrypt.DefaultCost)
    if err != nil{
		return err
	}  
	user.Password = string(hashedPassword)

	user.CreatedAt = time.Now()
	user.UpdatedAt = time.Now()

	ctx,  cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	_, err = r.Collection.InsertOne(ctx, user)
    return err
}