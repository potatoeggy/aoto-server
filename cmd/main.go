package main

import (
	"database/sql"
	"fmt"
	_ "fmt"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	_ "github.com/gin-gonic/gin"
	_ "github.com/lib/pq"
)

var db *sql.DB

const CONNECT_STR string = "postgres://app_user:password@localhost:5432/app_db?sslmode=disable"

type Book struct {
	Id          int64  `json:"id"`
	Title       string `json:"title"`
	Author      string `json:"author"`
	Isbn        string `json:"isbn"`
	Description string `json:"description"`
	Cover       string `json:"cover"`
	CreatedAt   string `json:"created_at"`
	UpdatedAt   string `json:"updated_at"`
}

func main() {

	var err error
	db, err = sql.Open("postgres", CONNECT_STR)

	if err != nil {
		fmt.Print("bad bad bad")
		return
	}

	fmt.Print("server is up\n")

	router := gin.Default()
	router.GET("/books", getBooks)
	router.Run("localhost:4000")
}

func getBooks(c *gin.Context) {

	rows, err := db.Query("SELECT * FROM api.books")

	if err != nil {
		log.Fatal(err)
		return
	}

	defer rows.Close()

	var books []Book
	for rows.Next() {
		var book Book

		if err := rows.Scan(&book.Id, &book.Title, &book.Author, &book.Isbn, &book.Description,
			&book.Cover, &book.CreatedAt, &book.UpdatedAt); err != nil {
			log.Fatal(err)
			return
		}

		books = append(books, book)
	}

	c.JSON(http.StatusOK, books)

}
