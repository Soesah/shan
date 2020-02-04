package server

import (
	"github.com/Soesah/shan.lostmarbles.nl/server/handlers"
	"github.com/go-chi/chi"
)

// Router creates a new router with all the routes attached
func Router() *chi.Mux {

	// config.Init()

	r := chi.NewRouter()

	r.Group(func(r chi.Router) {
		r.Get("/*", handlers.NotSupportedAPIHandler)
	})
	return r
}
