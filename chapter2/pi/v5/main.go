/*
 * Simple Go example, start programm with following command:
 *
 *  go run main.go 
 */
package main

import (
	"fmt"
	"os"
	"strconv"
	"time"
)

var step float64

func term(ch chan float64, i int) {
	x := (float64(i) + 0.5) * step
	x = 4.0 / (1.0 + x * x)
	
	ch <- x
}

func main() {
	var num_steps int
	ch := make(chan float64)

	if len(os.Args) > 1 {
		num_steps, _ = strconv.Atoi(os.Args[1])
	}
	if num_steps < 100 {
		num_steps = 1000000
	}
	fmt.Println("num_steps = ", num_steps)

	sum := float64(0)
	step = 1.0 / float64(num_steps)

	start := time.Now()

	for i := 0; i < num_steps; i++ {
		go term(ch, i)
	}

	for i := 0; i < num_steps; i++ {
		sum += <-ch
	}

	elapsed := time.Since(start)
	
	fmt.Println("Pi   : ", sum*step)
	fmt.Println("Time : ", elapsed)
}
