package words

import (
	"encoding/xml"
	"net/http"
	"strings"

	"github.com/Soesah/shan.lostmarbles.nl/api/models"
	"github.com/Soesah/shan.lostmarbles.nl/api/storage"
)

// GetWords returns the words
func GetWords(r *http.Request) ([]models.WordJSON, error) {
	c := Controller{}

	err := c.Load(r)
	var words models.Words

	bytes, err := storage.GetFile("words.xml", r)

	if err != nil {
		return c.Words.GetList(), err
	}

	decoder := xml.NewDecoder(strings.NewReader(string(bytes)))
	decoder.Strict = false
	decoder.Decode(&words)

	if err != nil {
		return words.GetList(), err
	}

	return words.GetList(), nil
}

// GetWordsBatch returns the words as XML
func GetWordsBatch(batch int, r *http.Request) ([]models.WordJSON, error) {
	var wordsBatch []models.WordJSON

	words, err := GetWords(r)

	if err != nil {
		return wordsBatch, err
	}

	for _, w := range words {
		if w.Batch == batch {
			wordsBatch = append(wordsBatch, w)
		}
	}

	return wordsBatch, err
}

// GetWordsXML returns the words as XML
func GetWordsXML(r *http.Request) ([]byte, error) {
	c := Controller{}

	return c.LoadXML(r)
}

// AddWord adds a word
func AddWord(word models.WordJSON, r *http.Request) (models.WordJSON, error) {

	return word, nil
}

// GetWord returns a word
func GetWord(uuid string, r *http.Request) (models.WordJSON, error) {
	var word models.WordJSON

	c := Controller{}
	err := c.Load(r)

	if err != nil {
		return word, err
	}

	word, err = c.GetWord(uuid)

	if err != nil {
		return word, err
	}

	return word, nil
}

// Update updates a word
func Update(word models.WordJSON, r *http.Request) (models.WordJSON, error) {

	return word, nil
}

// RemoveWord removes a word
func RemoveWord(uuid string, r *http.Request) error {

	return nil
}
