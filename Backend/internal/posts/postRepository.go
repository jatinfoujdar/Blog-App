package posts

import (
"context"
"time"

"go.mongodb.org/mongo-driver/bson"
"go.mongodb.org/mongo-driver/bson/primitive"
"go.mongodb.org/mongo-driver/mongo"
)

type PostRepository struct{
Collection *mongo.Collection
}

func NewPostRepository(c *mongo.Collection) *PostRepository {
return &PostRepository{Collection: c}
}

func (r *PostRepository) CreatePost(post *Post) error{
	post.ID = primitive.NewObjectID()
	post.CreatedAt = time.Now()
	post.UpdatedAt = time.Now()

	_, err := r.Collection.InsertOne(context.Background(), post)
	return err
}

func (r *PostRepository) GetAllPosts() ([]*Post, error){
	var posts []*Post

	cursor, err := r.Collection.Find(context.Background(), bson.M{})
	if err != nil {
		return nil, err
	}
	defer cursor.Close(context.Background())

	for cursor.Next(context.Background()) {
		var post Post
		if err := cursor.Decode(&post); err != nil {
			return nil, err
		}
		posts = append(posts, &post)
	}

	return posts, nil
}

