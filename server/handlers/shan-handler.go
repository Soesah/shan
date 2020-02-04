package handlers

import (
	"net/http"

	"github.com/Soesah/shan.lostmarbles.nl/api/words"
	"github.com/Soesah/shan.lostmarbles.nl/server/httpext"
)

// GetWords is used to get the words/characters from the db as an XML list
func GetWords(w http.ResponseWriter, r *http.Request) {
	words, err := words.GetWords(r)

	if err != nil {
		httpext.AbortAPI(w, err.Error(), http.StatusInternalServerError)
		return
	}

	httpext.SuccessXMLAPI(w, string(words))
}

// GetWordsAsJSON is used to get the words/characters from the db as a JSON list
func GetWordsAsJSON(w http.ResponseWriter, r *http.Request) {
	words, err := words.GetWordsData(r)

	if err != nil {
		httpext.AbortAPI(w, err.Error(), http.StatusInternalServerError)
		return
	}

	httpext.SuccessDataAPI(w, "Ok", words)
}
