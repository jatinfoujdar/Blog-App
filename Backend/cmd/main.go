package main

import (
	"fmt"

	"github.com/jatinfoujdar/Blog-App/internal/auth"
)

func init() {
	auth.LoadEnvVariable()
}

func main(){
	fmt.Println("Hello world!")
}