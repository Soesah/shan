package storage

import (
	"bytes"
	"errors"
	"io"
	"io/ioutil"
	"mime/multipart"
	"net/http"
	"os"
	"strings"

	"cloud.google.com/go/storage"
	"github.com/Soesah/shan.lostmarbles.nl/server/config"
	"golang.org/x/oauth2/google"
	"google.golang.org/api/option"
)

func fileToByteArray(file multipart.File) ([]byte, error) {
	defer file.Close()

	buf := bytes.NewBuffer(nil)
	if _, err := io.Copy(buf, file); err != nil {
		return nil, err
	}

	return buf.Bytes(), nil
}

// PutFile uploads a new file to the bucket
func PutFile(file string, data []byte, r *http.Request) error {

	conf := config.Get()

	if conf.IsDev() {
		dir, _ := os.Getwd()
		err := ioutil.WriteFile(strings.Join([]string{dir, "/data/", file}, ""), data, 0777)

		if err != nil {
			return err
		}

		return nil

	}

	ctx := r.Context()
	creds, err := google.FindDefaultCredentials(ctx, storage.ScopeReadWrite)
	if err != nil {
		return err
	}
	client, err := storage.NewClient(ctx, option.WithCredentials(creds))

	if err != nil {
		return err
	}

	path := strings.Join([]string{"data/", file}, "")

	// store the file
	bkt := client.Bucket(conf.BucketName)
	obj := bkt.Object(path)

	writer := obj.NewWriter(ctx)
	_, err = writer.Write(data)
	defer writer.Close()

	if err != nil {
		return err
	}

	return nil
}

// GetFile returns the bytes of the reference file.
func GetFile(file string, r *http.Request) ([]byte, error) {

	conf := config.Get()

	if conf.IsDev() {
		dir, _ := os.Getwd()
		bytes, err := ioutil.ReadFile(strings.Join([]string{dir, "/data/", file}, ""))

		if err != nil {
			return nil, err
		}

		return bytes, nil
	}

	ctx := r.Context()

	creds, err := google.FindDefaultCredentials(ctx, storage.ScopeReadWrite)
	if err != nil {
		return nil, err
	}
	client, err := storage.NewClient(ctx, option.WithCredentials(creds))

	if err != nil {
		return nil, err
	}

	path := strings.Join([]string{"data/", file}, "")

	bkt := client.Bucket(conf.BucketName)
	reader, err := bkt.Object(path).NewReader(ctx)

	if err != nil {
		return nil, errors.New(err.Error() + " " + path)
	}

	bytes, err := ioutil.ReadAll(reader)

	defer reader.Close()

	if err != nil {
		return nil, err
	}

	return bytes, nil
}
