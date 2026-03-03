package posts

import (
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
)

type PostHandler struct {
	Repo *PostRepository
}

func NewPostHandler(repo *PostRepository) *PostHandler {
	return &PostHandler{Repo: repo}
}

func (h *PostHandler) CreatePostHandler(c *gin.Context) {
	var post Post

	if err := c.ShouldBindJSON(&post); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "Invalid request body",
		})
		return
	}
	if email, exists := c.Get("userEmail"); exists {
		post.AuthorEmail = email.(string)
	}
	post.CreatedAt = time.Now()
	post.UpdatedAt = time.Now()

	if err := h.Repo.CreatePost(&post); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error": "Failed to create post",
		})
		return
	}
	c.JSON(http.StatusCreated, gin.H{
		"message": "Post created successfully",
		"data":    post,
	})
}

func (h *PostHandler) GetPostsHandler(c *gin.Context) {
	posts, err := h.Repo.GetAllPosts()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error": "Failed to fetch posts",
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"count": len(posts),
		"data":  posts,
	})
}
