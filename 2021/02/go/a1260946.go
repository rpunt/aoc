package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

type Position struct {
	forward_position int
	depth int
	aim int
}

func main() {
	depths, err := readLines("../inputs/a1260946.txt")
	if err != nil {
		log.Fatalf("readLines: %s", err)
	}

	//
	// part 1 - easy and dumb
	//
	forward_position := 0
	depth := 0
	for i := range depths {
		temp := strings.Split(depths[i], " ")
		direction := temp[0]
		unit, _ := strconv.Atoi(temp[1])

		switch direction {
		case "forward":
			forward_position += unit
		case "down":
			depth += unit
		case "up":
			depth -= unit
		}
	}

	fmt.Printf("part 1 product: %v\n", forward_position * depth)

	//
	// part 2
	//
	position := Position{
		aim: 0,
		depth: 0,
		forward_position: 0,
	}

	for i := range depths {
		temp := strings.Split(depths[i], " ")
		direction := temp[0]
		unit, _ := strconv.Atoi(temp[1])
		position = calculate_position(position, direction, unit)
	}

	// puts "part 2 product  : #{position.forward_position * position.depth}"
	fmt.Printf("part 2 product: %v\n", position.forward_position * position.depth)
}


func calculate_position(origin Position, direction string, unit int) (Position) {
	switch direction {
	case "forward":
		origin.forward_position += unit
		if origin.aim != 0 {
			origin.depth += unit * origin.aim
		}
	case "down":
		origin.aim += unit
	case "up":
		origin.aim -= unit
	}
  return origin
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
