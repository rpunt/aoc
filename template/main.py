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

def Part1(input):
  return 0

def Part2(input):
  return 0

part1 = Part1(input)
if args.testing:
  test_value_part_1 = 999
  if part1 != test_value_part_1:
    print('TEST VALUE IS WRONG: got {}, wanted {}'.format(part1, test_value_part_1))
  else:
    print(part1)

part2 = Part2(input)
if args.testing:
  test_value_part_2 = 999
  if part1 != test_value_part_2:
    print('TEST VALUE IS WRONG: got {}, wanted {}'.format(part2, test_value_part_2))
  else:
    print(part2)
