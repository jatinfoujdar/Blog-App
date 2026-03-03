package auth

import (
	"log"

	"github.com/joho/godotenv"
)

func LoadEnvVariable() {

	err := godotenv.Load()
	if err != nil {
		log.Println("Note: .env file not found, using system environment variables")
	}
}
