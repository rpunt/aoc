package main

import (
	"fmt"
	"strconv"
	"strings"

	utils "github.com/rpunt/aoc_utils"
)

type sectionsPair struct {
	Section1 utils.Intrange
	Section2 utils.Intrange
}

func main() {
	input := utils.ReadFile("input.txt")

	fmt.Printf("part 1: %v\n", Part1(input))
	fmt.Printf("part 2: %v\n", Part2(input))
}

func makeRange(section string) utils.Intrange {
	minmax := strings.Split(section, "-")
	min, err := strconv.Atoi(minmax[0])
	utils.CheckErr(err)
	max, err := strconv.Atoi(minmax[1])
	utils.CheckErr(err)
	return utils.Intrange{min, max}
}

func Part1(input []string) int {
	contains_count := 0
	for i := range input {
		elfpair := new(sectionsPair)
		pair := strings.Split(input[i], ",")
		elfpair.Section1 = makeRange(pair[0])
		elfpair.Section2 = makeRange(pair[1])
		if elfpair.Section1.Contains(elfpair.Section2) || elfpair.Section2.Contains(elfpair.Section1) {
			contains_count += 1
		}
	}
	return contains_count
}

func Part2(input []string) int {
	overlaps_count := 0
	for i := range input {
		elfpair := new(sectionsPair)
		pair := strings.Split(input[i], ",")
		elfpair.Section1 = makeRange(pair[0])
		elfpair.Section2 = makeRange(pair[1])
		if elfpair.Section1.Overlaps(elfpair.Section2) {
			overlaps_count += 1
		}
	}
	return overlaps_count
}
