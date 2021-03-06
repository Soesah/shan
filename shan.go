package main

import (
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/Soesah/shan.lostmarbles.nl/server/config"
	"github.com/Soesah/shan.lostmarbles.nl/server/handlers"
	"github.com/Soesah/shan.lostmarbles.nl/server/middlewares"
	"github.com/go-chi/chi"
	"github.com/go-chi/chi/middleware"
)

func main() {

	config.Init()
	conf := config.Get()

	r := chi.NewRouter()

	r.Group(func(r chi.Router) {

		// middleware
		r.Use(middleware.Compress(5))
		r.Use(middleware.RequestID)
		r.Use(middleware.RealIP)
		r.Use(middleware.Logger)
		r.Use(middleware.Recoverer)
		r.Use(middleware.Timeout(60 * time.Second))
		r.Use(middleware.RedirectSlashes)

		// api
		r.Route("/api", func(r chi.Router) {
			r.Use(middlewares.NoCache)
			r.Get("/words", handlers.GetWords)
			r.Get("/words/batch/{nr}", handlers.GetWordsBatch)
			r.Get("/words.xml", handlers.GetWordsXML)
			r.Post("/words", handlers.AddWord)
			r.Get("/words/{uuid}", handlers.GetWord)
			r.Put("/words/{uuid}", handlers.UpdateWord)
			r.Delete("/words/{uuid}", handlers.RemoveWord)
		})

	})

	r.Group(func(r chi.Router) {
		r.Get("/*", handlers.NotSupportedAPIHandler)
	})

	http.Handle("/", r)

	if conf.IsDev() {
		log.Print(fmt.Sprintf("Dev server listening on port %d", 8182))
		log.Fatal(http.ListenAndServe(":8182", r))
	} else {
		log.Fatal(http.ListenAndServe(":8080", r))
	}

}
