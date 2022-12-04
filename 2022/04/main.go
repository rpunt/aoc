package main

import (
	"fmt"
	"strconv"
	"strings"

	"github.com/rpunt/aoc/utils"
)

type sectionsPair struct {
	Section1 []int
	Section2 []int
}

func main() {
	input := utils.ReadFile("testable.txt")

	fmt.Printf("part 1: %v\n", Part1(input))
	// fmt.Printf("part 2: %v\n", Part2(input))
}

// create an array of sequential intergers
func makeRange(min, max int) []int {
	a := make([]int, max-min+1)
	for i := range a {
		a[i] = min + i
	}
	return a
}

func Intersection(a, b []int) (c []int) {
	m := make(map[int]bool)

	for _, item := range a {
		m[item] = true
	}

	for _, item := range b {
		if _, ok := m[item]; ok {
			c = append(c, item)
		}
	}
	return
}

func makeSection(section string) []int {
	minmax := strings.Split(section, "-")
	min, err := strconv.Atoi(minmax[0])
	utils.CheckErr(err)
	max, err := strconv.Atoi(minmax[1])
	utils.CheckErr(err)
	return makeRange(min, max)
}

func Part1(input []string) int {
	for i := range input {
		elfpair := new(sectionsPair)
		pair := strings.Split(input[i], ",")
		elfpair.Section1 = makeSection(pair[0])
		elfpair.Section2 = makeSection(pair[1])
		intersect := Intersection(elfpair.Section1, elfpair.Section2)
		if intersect == elfpair.Section1 || intersect == elfpair.Section2 {
			fmt.Println("found a match")
		}
		// minmax := strings.Split(pair, "-")
		// min := minmax[0]
		// max := minmax[1]
		// makeRange(min, max)
	}
	return 0
}

// func Part2(elfpair []string) int {
// 	return 0
// }
