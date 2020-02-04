package httpext

import (
	"encoding/json"
	"net/http"
)

// JSON encodes a JSON body
func JSON(w http.ResponseWriter, body interface{}) {
	w.Header().Add("Content-Type", "application/json")
	json.NewEncoder(w).Encode(body)
}

// Response is a standard response object
type Response struct {
	Error   string      `json:"error,omitempty"`
	Message string      `json:"message,omitempty"`
	Data    interface{} `json:"data,omitempty"`
}

// SuccessAPI returns a simple message
func SuccessAPI(w http.ResponseWriter, message string) {
	response := Response{
		Message: message,
	}

	JSON(w, response)
}

// SuccessDataAPI returns a json response with a message and data
func SuccessDataAPI(w http.ResponseWriter, message string, data interface{}) {
	response := Response{
		Message: message,
		Data:    data,
	}

	JSON(w, response)
}

// SuccessXMLAPI returns an xml response
func SuccessXMLAPI(w http.ResponseWriter, xml string) {
	xmlData := []byte(xml)
	w.Header().Add("Content-Type", "application/xml")
	w.Write(xmlData)
}

// AbortAPI returns an error with a message
func AbortAPI(w http.ResponseWriter, message string, status int) {
	response := Response{
		Message: message,
	}

	w.Header().Add("Content-Type", "application/json")
	// need to set status after content type
	w.WriteHeader(status)
	json.NewEncoder(w).Encode(response)
}
