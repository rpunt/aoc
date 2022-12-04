package main

import (
	"testing"

	utils "github.com/rpunt/aoc_utils"
)

var sample []string = utils.ReadFile("testable.txt")

func TestPartOne(t *testing.T) {
	tt := []struct {
		name     string
		input    []string
		expected int
	}{
		{
			name:     "example",
			input:    sample,
			expected: 24000,
		},
	}

	for _, tc := range tt {
		t.Run(tc.name, func(t *testing.T) {
			if got := Part1(tc.input); got != tc.expected {
				t.Errorf("Part1 = %v, want %v", got, tc.expected)
			}
		})
	}
}

func TestPartTwo(t *testing.T) {
	tt := []struct {
		name     string
		input    []string
		expected int
	}{
		{
			name:     "example",
			input:    sample,
			expected: 45000,
		},
	}

	for _, tc := range tt {
		t.Run(tc.name, func(t *testing.T) {
			if got := Part2(tc.input); got != tc.expected {
				t.Errorf("Part2 = %v, want %v", got, tc.expected)
			}
		})
	}
}
