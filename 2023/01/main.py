#!/usr/bin/env python3

import argparse
import re

parser = argparse.ArgumentParser(description="specify input file")
parser.add_argument('-i', '--inputfile', metavar="Inputfile", type=str, help="which input file should I use?", default='input')
parser.add_argument('-t', '--testing', help = 'use testing inputs', action = 'store_true')

args = parser.parse_args()

if args.testing == True:
  args.inputfile = 'testable'
path = args.inputfile + ".txt"
input = [line.rstrip() for line in open(path, 'r').readlines()]

if args.testing == True:
  args.inputfile = 'testable2'
path = args.inputfile + ".txt"
input2 = [line.rstrip() for line in open(path, 'r').readlines()]

def firstdigit(line):
  digits = [c for c in line if c.isdigit()]
  return int(digits[0])

def lastdigit(line):
  digits = [c for c in line if c.isdigit()]
  return int(digits[-1])

def Part1(input):
  sum = 0
  for line in input:
    sum += firstdigit(line)*10 + lastdigit(line)
  return sum

def Part2(input):
  sum = 0
  number_words = [(item, i) for i, item in enumerate("one two three four five six seven eight nine".split(), 1)]
  for line in input2:
    orig_line = line
    for k,v in number_words:
      # k = one, v = 1
      line = line.replace(k, str(v))
    linesum = firstdigit(line)*10 + lastdigit(line)
    sum += linesum
    print(orig_line + "\t" + line + "\t" + str(linesum))
  return sum

part1 = Part1(input)
if args.testing:
  test_value_part_1 = 142
  if part1 != test_value_part_1:
    print('TEST VALUE IS WRONG: got {}, wanted {}'.format(part1, test_value_part_1))
else:
  print(part1)

part2 = Part2(input2)
if args.testing:
  test_value_part_2 = 281
  if part1 != test_value_part_2:
    print('TEST VALUE IS WRONG: got {}, wanted {}'.format(part2, test_value_part_2))
else:
  print(part2)
