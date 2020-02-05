package words

import (
	"encoding/json"
	"encoding/xml"
	"errors"
	"net/http"
	"strings"

	"github.com/Soesah/shan.lostmarbles.nl/api/models"
	"github.com/Soesah/shan.lostmarbles.nl/api/storage"
)

var (
	errNotInitialized = errors.New("Controller not initialized")
	errNoWordsToSave  = errors.New("No words to save")
	errWordNotFound   = errors.New("Word not found, uuid incorrect")
)

// Controller is used to easily add, update and get words
type Controller struct {
	Words models.Words
	NewID string
}

// LoadXML loads the XML of the words
func (c *Controller) LoadXML(r *http.Request) ([]byte, error) {
	bytes, err := storage.GetFile("words.xml", r)

	if err != nil {
		return bytes, err
	}

	return bytes, nil
}

// Load loads the words
func (c *Controller) Load(r *http.Request) error {
	var words models.Words

	bytes, err := c.LoadXML(r)

	if err != nil {
		return err
	}

	decoder := xml.NewDecoder(strings.NewReader(string(bytes)))
	decoder.Strict = false
	decoder.Decode(&words)

	if err != nil {
		return err
	}

	c.Words = words

	return nil
}

// Store saves the database
func (c *Controller) Store(r *http.Request) error {

	if len(c.Words.Words) == 0 {
		return errNoWordsToSave
	}

	data, err := json.MarshalIndent(c.Words, "", "  ")

	if err != nil {
		return err
	}

	err = storage.PutFile("words.xml", data, r)

	if err != nil {
		return err
	}

	return nil
}

// GetWord gets a word from  the database
func (c *Controller) GetWord(uuid string) (models.WordJSON, error) {
	var word models.WordJSON
	for _, w := range c.Words.Words {
		if w.ID == uuid {
			return w.GetJSON(), nil
		}
	}
	return word, errWordNotFound
}
