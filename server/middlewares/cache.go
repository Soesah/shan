package middlewares

import (
	"fmt"
	"net/http"
	"time"
)

var epoch = time.Unix(0, 0).Format(time.RFC1123)

// NoCache header
func NoCache(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Expires", epoch)
		w.Header().Set("Cache-Control", "no-cache, private, max-age=0")
		next.ServeHTTP(w, r)
	})
}

// Cache header for a specific time
func Cache(duration time.Duration) func(next http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			now := time.Now()
			expiresAt := now.Add(duration).UTC()

			w.Header().Set("Expires", expiresAt.Format(time.RFC1123))
			w.Header().Set("Cache-Control", fmt.Sprintf("public, max-age=%d", duration/time.Second))

			next.ServeHTTP(w, r)
		})
	}
}
