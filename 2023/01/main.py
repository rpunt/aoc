#!/usr/bin/env python3

import argparse

parser = argparse.ArgumentParser(description="specify input file")
parser.add_argument('-i', '--inputfile', metavar="Inputfile", type=str, help="which input file should I use?", default='input')
parser.add_argument('-t', '--testing', help = 'use testing inputs', action = 'store_true')

args = parser.parse_args()

if args.testing == True:
  args.inputfile = 'testable'

path = args.inputfile + ".txt"

input = [line.rstrip() for line in open(path, 'r').readlines()]

# def numeric?(char)
#   char.match?(/[[:digit:]]/)
# end

def firstdigit(line):
  # line.split('').each do |char|
  #   return char.to_i if numeric?(char)
  # end
  return 0

def lastdigit(line):
  # line.reverse.split('').each do |char|
  #   return char.to_i if numeric?(char)
  # end
  return 0

def Part1(input):
  sum = 0
  for line in input:
    sum += firstdigit(line)*10 + lastdigit(line)
  return sum

def Part2(input):
  return 0

part1 = Part1(input)
print(part1)
if args.testing:
  test_value_part_1 = 142
  if part1 != test_value_part_1:
    print('TEST VALUE IS WRONG: got {}, wanted {}'.format(part1, test_value_part_1))

# part2 = Part2(input)
# print(part2)
# if args.testing:
#   test_value_part_2 = 999
#   if part1 != test_value_part_2:
#     print('TEST VALUE IS WRONG: got {}, wanted {}'.format(part2, test_value_part_2))
