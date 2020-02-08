package handlers

import (
	"encoding/json"
	"net/http"
	"strconv"

	"github.com/Soesah/shan.lostmarbles.nl/api/models"
	"github.com/Soesah/shan.lostmarbles.nl/api/words"
	"github.com/Soesah/shan.lostmarbles.nl/server/httpext"
	"github.com/go-chi/chi"
)

// AddWord is used to add a words/character in the db
func AddWord(w http.ResponseWriter, r *http.Request) {
	decoder := json.NewDecoder(r.Body)
	var word models.WordJSON
	err := decoder.Decode(&word)

	if err != nil {
		httpext.AbortAPI(w, err.Error(), http.StatusBadRequest)
		return
	}

	word, err = words.AddWord(word, r)

	if err != nil {
		httpext.AbortAPI(w, err.Error(), http.StatusInternalServerError)
		return
	}

	httpext.SuccessDataAPI(w, "Ok", word)
}

// GetWord is used to get a specific words/character from the db
func GetWord(w http.ResponseWriter, r *http.Request) {
	uuid := chi.URLParam(r, "uuid")
	word, err := words.GetWord(uuid, r)

	if err != nil {
		httpext.AbortAPI(w, err.Error(), http.StatusInternalServerError)
		return
	}

	httpext.SuccessDataAPI(w, "Ok", word)
}

// UpdateWord is used to update a specific words/character in the db
func UpdateWord(w http.ResponseWriter, r *http.Request) {
	decoder := json.NewDecoder(r.Body)
	var word models.WordJSON
	err := decoder.Decode(&word)

	if err != nil {
		httpext.AbortAPI(w, err.Error(), http.StatusInternalServerError)
		return
	}
	word, err = words.Update(word, r)

	if err != nil {
		httpext.AbortAPI(w, err.Error(), http.StatusInternalServerError)
		return
	}

	httpext.SuccessDataAPI(w, "Ok", word)
}

// RemoveWord is used to remove a specific words/character from the db
func RemoveWord(w http.ResponseWriter, r *http.Request) {
	uuid := chi.URLParam(r, "uuid")
	err := words.RemoveWord(uuid, r)

	if err != nil {
		httpext.AbortAPI(w, err.Error(), http.StatusInternalServerError)
		return
	}

	httpext.SuccessAPI(w, "Ok")
}

// GetWords is used to get the words/characters from the db as a JSON list
func GetWords(w http.ResponseWriter, r *http.Request) {
	words, err := words.GetWords(r)

	if err != nil {
		httpext.AbortAPI(w, err.Error(), http.StatusInternalServerError)
		return
	}

	httpext.SuccessDataAPI(w, "Ok", words)
}

// GetWordsBatch is used to get the words/characters from the db as a JSON list
func GetWordsBatch(w http.ResponseWriter, r *http.Request) {
	nr, err := strconv.Atoi(chi.URLParam(r, "nr"))

	words, err := words.GetWordsBatch(nr, r)

	if err != nil {
		httpext.AbortAPI(w, err.Error(), http.StatusInternalServerError)
		return
	}

	httpext.SuccessDataAPI(w, "Ok", words)
}

// GetWordsXML is used to get the words/characters from the db as an XML list
func GetWordsXML(w http.ResponseWriter, r *http.Request) {
	words, err := words.GetWordsXML(r)

	if err != nil {
		httpext.AbortAPI(w, err.Error(), http.StatusInternalServerError)
		return
	}

	httpext.SuccessXMLAPI(w, string(words))
}
