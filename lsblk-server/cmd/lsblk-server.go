package main

import (
	"fmt"
	"net/http"
	"os"
	"os/exec"

	"github.com/rs/cors"
)

func main() {
	arg := (os.Args[1:])[0]
	fmt.Println(arg)

	if arg == "start" {
		fmt.Println("A")
		start()
	}
}

func start() {
	mux := http.DefaultServeMux
	mux.HandleFunc("/lsblk", func(rw http.ResponseWriter, r *http.Request) {
		fmt.Println("HIT!")
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
