package portfolio

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

func (h *Handler) GetPortfolioHandler(c *gin.Context) {
	email, _ := c.Get("userEmail")
	emailStr := email.(string)

	balance, err := h.Repo.GetUserBalance(emailStr)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "failed to fetch balance"})
		return
	}

	holdings, err := h.Repo.GetHoldings(emailStr)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "failed to fetch holdings"})
		return
	}

	c.JSON(http.StatusOK, Portfolio{
		UserEmail: emailStr,
		Holdings:  holdings,
		Balance:   balance,
	})
}

func (h *Handler) BuyStockHandler(c *gin.Context) {
	var req struct {
		StockName string  `json:"stockName" binding:"required"`
		Price     float64 `json:"price" binding:"required"`
		Quantity  int     `json:"quantity" binding:"required"`
	}

	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "invalid request body"})
		return
	}

	email, _ := c.Get("userEmail")
	emailStr := email.(string)

	trade := &Trade{
		UserEmail:   emailStr,
		StockName:   req.StockName,
		Type:        Buy,
		Price:       req.Price,
		Quantity:    req.Quantity,
		TotalAmount: req.Price * float64(req.Quantity),
	}

	if err := h.Repo.ExecuteTrade(emailStr, trade); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{
		"message": "Stock purchased successfully",
		"trade":   trade,
	})
}

func (h *Handler) SellStockHandler(c *gin.Context) {
	var req struct {
		StockName string  `json:"stockName" binding:"required"`
		Price     float64 `json:"price" binding:"required"`
		Quantity  int     `json:"quantity" binding:"required"`
	}

	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "invalid request body"})
		return
	}

	email, _ := c.Get("userEmail")
	emailStr := email.(string)

	trade := &Trade{
		UserEmail:   emailStr,
		StockName:   req.StockName,
		Type:        Sell,
		Price:       req.Price,
		Quantity:    req.Quantity,
		TotalAmount: req.Price * float64(req.Quantity),
	}

	if err := h.Repo.ExecuteTrade(emailStr, trade); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{
		"message": "Stock sold successfully",
		"trade":   trade,
	})
}

func (h *Handler) AddBalanceHandler(c *gin.Context) {
	var req struct {
		Amount float64 `json:"amount" binding:"required"`
	}

	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "invalid request body"})
		return
	}

	email, _ := c.Get("userEmail")
	emailStr := email.(string)

	if err := h.Repo.UpdateBalance(emailStr, req.Amount); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "failed to update balance"})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"message": "Balance updated successfully",
	})
}
