package main

import (
	"fmt"
	"strings"

	utils "github.com/rpunt/aoc_utils"
)

type Choice int

const (
	Unknown Choice = iota
	Rock
	Paper
	Scissors
)

func SymbolToValue(symbol string) Choice {
	switch symbol {
	case "A", "X":
		return Rock
	case "B", "Y":
		return Paper
	case "C", "Z":
		return Scissors
	default:
		return Unknown
	}
}

func NewRequiredChoice(c Choice, s string) Choice {
	switch s {
	case "X": // must lose
		switch c {
		case Rock:
			return Scissors
		case Paper:
			return Rock
		case Scissors:
				return Paper
		}

	case "Y": // must draw
		return c

	case "Z": // must win
		switch c {
		case Rock:
			return Paper
		case Paper:
			return Scissors
		case Scissors:
			return Rock
		}
	}

	return Unknown
}

type Round struct {
	Player1 Choice
	Player2 Choice
}

func NewRound(ch1, ch2 Choice) *Round {
	return &Round{
		Player1: ch1,
		Player2: ch2,
	}
}

func (c Choice) Score() int {
	return int(c)
}

func (r Round) TotalScore() int {
	roundScore := r.Player2.Score()

	// draw
	if r.Player1 == r.Player2 {
		return roundScore + 3
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

func Part1(calories []string) int {
	rounds := []*Round{}

	for _, line := range calories {
		arr := strings.Split(line, " ")
		round := NewRound(SymbolToValue(arr[0]), SymbolToValue(arr[1]))
		rounds = append(rounds, round)
	}

	totalScore := 0
	for _, r := range rounds {
		totalScore += r.TotalScore()
	}

	return totalScore
}

func Part2(calories []string) int {
	rounds := []*Round{}

	for _, line := range calories {
		arr := strings.Split(line, " ")
		ch1 := SymbolToValue(arr[0])
		round := NewRound(ch1, NewRequiredChoice(ch1, arr[1]))
		rounds = append(rounds, round)
	}

	totalScore := 0
	for _, r := range rounds {
		totalScore += r.TotalScore()
	}

	return totalScore
}
