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

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	r.Run(":" + port)
}
