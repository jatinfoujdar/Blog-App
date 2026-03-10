package tasks

import (
	"context"
	"time"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

type TaskRepository struct {
	Collection *mongo.Collection
}

func NewTaskRepository(c *mongo.Collection) *TaskRepository {
	return &TaskRepository{Collection: c}
}

func (r *TaskRepository) CreateTask(task *Task) error {
	task.ID = primitive.NewObjectID()
	task.CreatedAt = time.Now()
	task.UpdatedAt = time.Now()
	_, err := r.Collection.InsertOne(context.Background(), task)
	return err
}

func (r *TaskRepository) GetTasksByEmail(email string) ([]*Task, error) {
	var tasks []*Task
	cursor, err := r.Collection.Find(context.Background(), bson.M{"authorEmail": email})
	if err != nil {
		return nil, err
	}
	defer cursor.Close(context.Background())
	for cursor.Next(context.Background()) {
		var task Task
		if err := cursor.Decode(&task); err != nil {
			return nil, err
		}
		tasks = append(tasks, &task)
	}
	return tasks, nil
}

func (r *TaskRepository) UpdateTask(id primitive.ObjectID, email string, updates bson.M) error {
	updates["updatedAt"] = time.Now()
	_, err := r.Collection.UpdateOne(
		context.Background(),
		bson.M{"_id": id, "authorEmail": email},
		bson.M{"$set": updates},
	)
	return err
}

func (r *TaskRepository) DeleteTask(id primitive.ObjectID, email string) error {
	_, err := r.Collection.DeleteOne(
		context.Background(),
		bson.M{"_id": id, "authorEmail": email},
	)
	return err
}
