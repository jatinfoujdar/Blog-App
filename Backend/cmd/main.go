package main

import (
	"github.com/gin-gonic/gin"
	"github.com/jatinfoujdar/Blog-App/internal/auth"
)

func init() {
	auth.LoadEnvVariable()
}

func main(){
	r := gin.Default()

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})
}