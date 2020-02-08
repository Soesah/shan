package models

import "encoding/xml"

// Words is the words element in the XML
type Words struct {
	XMLName xml.Name `json:"-" xml:"words"`
	Words   []Word   `json:"words" xml:"word"`
}

// GetList returns a nicer JSON format for the words list
func (w *Words) GetList() []WordJSON {
	var list []WordJSON

	for _, word := range w.Words {
		list = append(list, word.GetJSON())
	}

	return list
}

// Word is the word element in the XML
type Word struct {
	Character Character `json:"character,omitempty" xml:"character,omitempty"`
	Pinyin    Pinyin    `json:"pinyin" xml:"pinyin"`
	Meanings  Meanings  `json:"meanings" xml:"meanings"`
	ID        string    `json:"id" xml:"id,attr"`
	Batch     int       `json:"batch" xml:"batch,attr,omitempty"`
}

// GetJSON returns a nicer JSON format for the word
func (w *Word) GetJSON() WordJSON {
	return WordJSON{
		Character: w.Character,
		Pinyin:    w.Pinyin,
		Meanings:  w.Meanings.Meaning,
		ID:        w.ID,
		Batch:     w.Batch,
	}
}

// Character is the Chinese character(s) of the word
type Character struct {
	Page     int    `json:"page,omitempty" xml:"page,attr,omitempty"`
	Position int    `json:"position,omitempty" xml:"position,attr,omitempty"`
	Value    string `json:"value" xml:",chardata"`
	Lang     string `json:"lang" xml:"http://www.w3.org/XML/1998/namespace lang,attr,omitempty"`
}

// Pinyin is pinyin representation of the word(s)
type Pinyin struct {
	Order string `json:"order,omitempty" xml:"order-string,attr"`
	Text  string `json:"text,omitempty" xml:"text,attr"`
	Value string `json:"value" xml:",chardata"`
	Lang  string `json:"lang" xml:"http://www.w3.org/XML/1998/namespace lang,attr,omitempty"`
}

// Meanings contains the meaning(s) of the word
type Meanings struct {
	Meaning []Meaning `json:"meanings" xml:"meaning"`
}

// Meaning contains the meaning(s) of the word
type Meaning struct {
	Value string `json:"value" xml:",chardata"`
	Lang  string `json:"lang" xml:"http://www.w3.org/XML/1998/namespace lang,attr,omitempty"`
}

// WordJSON is a nicer JSON format for a word
type WordJSON struct {
	Character Character `json:"character,omitempty"`
	Pinyin    Pinyin    `json:"pinyin"`
	Meanings  []Meaning `json:"meanings" `
	ID        string    `json:"id"`
	Batch     int       `json:"batch"`
}

// GetWord returns a Word for WordJSON
func (w *WordJSON) GetWord() Word {
	return Word{
		Character: w.Character,
		Pinyin:    w.Pinyin,
		Meanings: Meanings{
			Meaning: w.Meanings,
		},
		ID:    w.ID,
		Batch: w.Batch,
	}
}
