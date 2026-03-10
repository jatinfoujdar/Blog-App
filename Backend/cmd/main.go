package main

import (
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/jatinfoujdar/Blog-App/internal/auth"
	"github.com/jatinfoujdar/Blog-App/internal/db"
	"github.com/jatinfoujdar/Blog-App/internal/middleware"
	"github.com/jatinfoujdar/Blog-App/internal/posts"
	"github.com/jatinfoujdar/Blog-App/internal/tasks"
)

func init() {
	auth.LoadEnvVariable()
	db.ConnectDB()
}

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	r := gin.Default()

	dbName := os.Getenv("DB_NAME")
	if dbName == "" {
		dbName = "blog_app"
	}
	userCollection := db.Client.Database(dbName).Collection("users")
	userRepo, err := auth.NewUserRepository(userCollection)
	if err != nil {
		panic(err)
	}

	postCollection := db.Client.Database(dbName).Collection("posts")
	postRepo := posts.NewPostRepository(postCollection)
	postHandler := posts.NewPostHandler(postRepo)

	taskCollection := db.Client.Database(dbName).Collection("tasks")
	taskRepo := tasks.NewTaskRepository(taskCollection)
	taskHandler := tasks.NewTaskHandler(taskRepo)

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	r.POST("/signup", auth.RegisterHandler(userRepo))
	r.POST("/login", auth.LoginHandler(userRepo))

	protected := r.Group("/")
	protected.Use(middleware.AuthMiddleware())
	{
		protected.GET("/profile", func(c *gin.Context) {
			email, _ := c.Get("userEmail")
			user, err := userRepo.GetUserByEmail(email.(string))
			if err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"error": "could not fetch user"})
				return
			}
			c.JSON(200, user)
		})
		protected.PUT("/profile", auth.UpdateProfileHandler(userRepo))

		protected.POST("/posts", postHandler.CreatePostHandler)
		protected.GET("/posts", postHandler.GetPostsHandler)

		protected.GET("/tasks", taskHandler.GetTasksHandler)
		protected.POST("/tasks", taskHandler.CreateTaskHandler)
		protected.PUT("/tasks/:id", taskHandler.ToggleTaskHandler)
		protected.DELETE("/tasks/:id", taskHandler.DeleteTaskHandler)
	}

	r.Run(":" + port)
}
