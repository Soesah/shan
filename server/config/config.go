package config

import (
	"log"

	"github.com/caarlos0/env"
)

// Config provides some config options
type Config struct {
	ENVIRONMENT string `env:"ENVIRONMENT"`
	DistFolder  string `env:"DIST_FOLDER"`
	BucketName  string `env:"CLOUD_STORAGE_BUCKET"`
}

var conf = Config{}

// IsDev returns whether or not the ENVIRONMENT is Dev
func (c *Config) IsDev() bool {
	return c.ENVIRONMENT == ""
}

// IsMaster returns whether or not the ENVIRONMENT is Master
func (c *Config) IsMaster() bool {
	return c.ENVIRONMENT == "master"
}

// Init reads the configuration and sets the keys to the values in app.yaml
func Init() {
	err := env.Parse(&conf)
	if err != nil {
		log.Fatal(err)
	}
}

// Get provides access
func Get() Config {
	return conf
}
