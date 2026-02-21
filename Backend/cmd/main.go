package main

import (
	"os"

	"github.com/gin-gonic/gin"
	"github.com/jatinfoujdar/Blog-App/internal/auth"
)

func init() {
	auth.LoadEnvVariable()
	ConnectDB()
}

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	r := gin.Default()

	// Initialize Repository
	dbName := os.Getenv("DB_NAME")
	if dbName == "" {
		dbName = "blog_app"
	}
	userCollection := Client.Database(dbName).Collection("users")
	userRepo, err := auth.NewUserRepository(userCollection)
	if err != nil {
		panic(err)
	}

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	// Auth Routes
	r.POST("/signup", auth.RegisterHandler(userRepo))
	r.POST("/login", auth.LoginHandler(userRepo))

	r.Run(":" + port)
}
