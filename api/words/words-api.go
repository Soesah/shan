package words

import (
	"encoding/xml"
	"net/http"
	"strings"

	"github.com/Soesah/shan.lostmarbles.nl/api/models"
	"github.com/Soesah/shan.lostmarbles.nl/api/storage"
)

// GetWords returns the words
func GetWords(r *http.Request) ([]byte, error) {
	var bytes []byte

	bytes, err := storage.GetFile("words.xml", r)

	if err != nil {
		return bytes, err
	}

	return bytes, nil
}

// GetWordsData returns the words
func GetWordsData(r *http.Request) ([]models.WordJSON, error) {
	var words models.Words

	bytes, err := storage.GetFile("words.xml", r)

	if err != nil {
		return words.GetList(), err
	}

	decoder := xml.NewDecoder(strings.NewReader(string(bytes)))
	decoder.Strict = false
	decoder.Decode(&words)

	if err != nil {
		return words.GetList(), err
	}

	return words.GetList(), nil
}
