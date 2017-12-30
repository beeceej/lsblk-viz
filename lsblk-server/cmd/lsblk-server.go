package main

import (
	"net/http"
	"os/exec"

	"github.com/rs/cors"
)

func main() {
	mux := http.DefaultServeMux
	mux.HandleFunc("/lsblk", func(rw http.ResponseWriter, r *http.Request) {
		rw.Write(func(b []byte, err error) []byte {
			if err != nil {
				panic(err.Error())
			}
			return b
		}(exec.Command("lsblk", "--json").Output()))
	})
	handler := cors.Default().Handler(mux)
	http.ListenAndServe(":9999", handler)
}
