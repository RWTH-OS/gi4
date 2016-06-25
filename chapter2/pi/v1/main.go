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

func term(i int, step float64) (x float64) {
	x = (float64(i) + 0.5) * step
	x = 4.0 / (1.0 + x * x)

	return
}

func main() {
	var num_steps int

	if len(os.Args) > 1 {
		num_steps, _ = strconv.Atoi(os.Args[1])
	}
	if num_steps < 100 {
		num_steps = 1000000
	}
	fmt.Println("num_steps = ", num_steps)

	sum := float64(0)
	step := 1.0 / float64(num_steps)

	start := time.Now()

	for i := 0; i < num_steps; i++ {
		sum += term(i, step)
	}

	elapsed := time.Since(start)
	
	fmt.Println("Pi   : ", sum*step)
	fmt.Println("Time : ", elapsed)
}
