package models

import "time"

type FlashData struct {
	CurrentBatch   int             `json:"currentBatch"`
	Date           time.Time       `json:"date"`
	WordsPracticed []FlashDataWord `json:"wordsPracticed"`
	Previous       []FlashData     `json:"previous,omitempty"`
}

type FlashDataWord struct {
	ID   string    `json:"id"`
	Date time.Time `json:"date"`
}
