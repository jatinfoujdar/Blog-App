package kyc

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type Handler struct {
	Repo *Repository
}

func NewHandler(repo *Repository) *Handler {
	return &Handler{Repo: repo}
}

func (h *Handler) SubmitKYCHandler(c *gin.Context) {
	var submission KYCSubmission
	if err := c.ShouldBindJSON(&submission); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "invalid request body"})
		return
	}

	email, _ := c.Get("userEmail")
	submission.UserEmail = email.(string)

	if err := h.Repo.SubmitKYC(&submission); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "failed to submit KYC"})
		return
	}

	c.JSON(http.StatusAccepted, gin.H{
		"message": "KYC submitted successfully and is pending verification",
	})
}

func (h *Handler) GetKYCStatusHandler(c *gin.Context) {
	email, _ := c.Get("userEmail")
	status, err := h.Repo.GetKYCStatus(email.(string))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "failed to fetch KYC status"})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"status": status,
	})
}

// Admin mock endpoint to verify KYC for testing
func (h *Handler) AdminVerifyKYCHandler(c *gin.Context) {
	var req struct {
		Email string `json:"email" binding:"required"`
	}
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "invalid request body"})
		return
	}

	if err := h.Repo.VerifyKYC(req.Email); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "failed to verify KYC"})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "KYC verified successfully",
	})
}
