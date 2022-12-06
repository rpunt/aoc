package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
)

func main() {
	depths, err := readLines("../inputs/a1260946.txt")
	if err != nil {
		log.Fatalf("readLines: %s", err)
	}

	fmt.Printf("part 1: %v\n", sumwindow(depths, 1))
	fmt.Printf("part 2: %v\n", sumwindow(depths, 3))
}

func sumwindow(depths []string, n int) uint64 {
	count := 0
	for i := 0; i < len(depths) - n; i++ {
		currentdepth, _ := strconv.Atoi(depths[i])
		nextdepth, _ := strconv.Atoi(depths[i+n])
		if currentdepth < nextdepth {
			count++
		}
	}
	return uint64(count)
}

func readLines(path string) ([]string, error) {
    file, err := os.Open(path)
    if err != nil {
        return nil, err
    }
    defer file.Close()

    var lines []string
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        lines = append(lines, scanner.Text())
    }
    return lines, scanner.Err()
}
