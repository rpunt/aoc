package main

import (
	"fmt"

	"github.com/rpunt/aoc/utils"
)

type Choice int


type Round struct {
	Player1 Choice
	Player2 Choice
}

func (c Choice) Score() int {
	return int(c)
}

func (r Round) TotalScore() int {
	roundScore := r.Player2.Score()

	// draw
	if r.Player1 == r.Player2 {
		return score + 3
	}

	if r.Player1 == Rock {
		if r.Player2 == Paper {
			return roundScore + 6
		}
	}

	if r.Player1 == Paper {
		if r.Player2 == Scissors {
			return roundScore + 6
		}
	}

	if r.Player1 == Scissors {
		if r.Player2 == Rock {
			return roundScore + 6
		}
	}

	return roundScore
}

func main() {
	input := utils.ReadFile("input.txt")

	fmt.Printf("part 1: %v\n", Part1(input))
	fmt.Printf("part 2: %v\n", Part2(input))
}

const {
	int Rock = 1
	int Paper = 2
	int Scissors = 3
}

func Part1(calories []string) int {
	return 0
}

func Part2(calories []string) int {
	return 0
}
