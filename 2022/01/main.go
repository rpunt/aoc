package main

import (
	"fmt"
	"sort"
	"strconv"

	utils "github.com/rpunt/aoc_utils"
)

func main() {
	input := utils.ReadFile("input.txt")

	fmt.Printf("part 1: %v\n", Part1(input))
	fmt.Printf("part 2: %v\n", Part2(input))
}

func Part1(calories []string) int {
	calories_by_elf := total_elvish_calories(calories)
	return topX(calories_by_elf, 1)
}

func Part2(calories []string) int {
	calories_by_elf := total_elvish_calories(calories)
	return topX(calories_by_elf, 3)
}

func topX(calories []int, x int) int {
	// sum the x highest array values
	sort.Sort(sort.Reverse(sort.IntSlice(calories)))
	summed_calories := 0
	for i := 0; i < x; i++ {
		summed_calories += calories[i]
	}

	return summed_calories
}

func total_elvish_calories(inventory []string) []int {
	// return a new array containing per-elf caloric totals
	var elvish_calorie_load []int
	calories := 0
	for _, food := range inventory {
		calorie, err := strconv.Atoi(food)
		if err != nil {
			elvish_calorie_load = append(elvish_calorie_load, calories)
			calories = 0
		}
		calories += calorie
	}
	elvish_calorie_load = append(elvish_calorie_load, calories)
	return elvish_calorie_load
}
