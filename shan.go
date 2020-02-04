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
		r.Use(middleware.DefaultCompress)
		r.Use(middleware.RequestID)
		r.Use(middleware.RealIP)
		r.Use(middleware.Logger)
		r.Use(middleware.Recoverer)
		r.Use(middleware.Timeout(60 * time.Second))
		r.Use(middleware.RedirectSlashes)

		// api
		r.Route("/api", func(r chi.Router) {
			r.Use(middlewares.NoCache)
			r.Get("/words.xml", handlers.GetWords)
			r.Get("/words.json", handlers.GetWordsAsJSON)
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
