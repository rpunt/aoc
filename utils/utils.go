package utils

// "borrowed" from https://github.com/golangroma/aoc/blob/main/utils/utils.go

import (
	"log"
	"os"
	"strings"
)

// read a text file into a string array
func ReadFile(filename string) []string {
	content, err := os.ReadFile(filename)
	CheckErr(err)

	return SplitInput(string(content))
}

// split a string into an array, on "\n"
func SplitInput(content string) []string {
	stringContent := strings.TrimSpace(string(content))
	return strings.Split(stringContent, "\n")
}

// Check for and log errors
func CheckErr(err error) {
	if err != nil {
		log.Fatal(err)
	}
}
