package main

import (
	"encoding/csv"
	"flag"
	"fmt"
	"log"
	"os"
	"strconv"
)

func readCsvFile(filePath string) ([][]string, error) {
	f, err := os.Open(filePath)
	if err != nil {
		log.Fatal("Unable to read input file "+filePath, err)
	}
	defer f.Close()

	csvReader := csv.NewReader(f)
	records, err := csvReader.ReadAll()
	if err != nil {
		return nil, err
	}

	return records, nil
}

func linear_sum(n int) int {
	return (n * (n + 1)) / 2
}

func ToInt(s string) (i int) {
	i, err := strconv.Atoi(s)
	if err != nil {
		panic(err)
	}
	return
}

func Abs(a int) int {
	if a < 0  {
		return a * -1
	}
	return a
}

func Min(arr []string) int {
	min := ToInt(arr[0])
	for _, val := range arr {
		val := ToInt(val)
		if (val < min) {
			min = val
		}
	}
	return min
}

func Max(arr []string) int {
	max := ToInt(arr[0])
	for _, val := range arr {
		val := ToInt(val)
		if (val < max) {
			max = val
		}
	}
	return max
}

func main() {
	testable := flag.Bool("t", false, "use test inputs")
	flag.Parse()
	var inputflag string
	if (*testable) {
		inputflag = "testable"
	} else {
		inputflag= os.Getenv("USER")
	}

	inputflag = "testable"
	inputfile := fmt.Sprintf("../inputs/%v.txt", inputflag)
	inputfile = "/Users/a1260946/dev/adventofcode/2021/07/inputs/testable.txt"

	distances, err := readCsvFile(inputfile)
	if err != nil {
		log.Fatal("Got error from readCsvFile", err)
	}

	fmt.Printf("distances: %v\n", distances[0])

	D := make(map[int]int)
	S := make(map[int]int)
	// for possible_distance in (crabs.min..crabs.max) do
	for possible_distance := Min(distances[0]); possible_distance <= Max(distances[0]); possible_distance++ {
		fmt.Printf("possible_distance: %v\n", possible_distance)
		fmt.Printf("D: %v\n", D)
		fmt.Printf("S: %v\n", S)
		D[possible_distance] = 0
		S[possible_distance] = 0
		// 	for distances in distances do
		for _, distance := range distances[0] {
			distance := ToInt(distance)
			fmt.Printf("distance: %v\n", distance)
			position_delta := Abs(distance - possible_distance)
			D[possible_distance] += position_delta
			S[possible_distance] += linear_sum(position_delta)
		}

		fmt.Printf("D: %v\n", D)
		fmt.Printf("S: %v\n", S)
		// puts "Part 1: #{D.key(D.values.min)} moves, #{D.values.min} fuel"
		// puts "Part 2: #{S.key(S.values.min)} moves, #{S.values.min} fuel"
	}
}
