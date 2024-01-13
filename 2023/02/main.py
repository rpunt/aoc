#!/usr/bin/env python3

#region setup
import argparse
import re
from colorama import Fore
from collections import defaultdict
import math

parser = argparse.ArgumentParser(description="specify input file")
parser.add_argument('-i', '--inputfile', metavar="Inputfile", type=str, help="which input file should I use?", default='input')
parser.add_argument('-t', '--testing', help = 'use testing inputs', action = 'store_true')

args = parser.parse_args()

if args.testing == True:
  args.inputfile = 'testable'

path = args.inputfile + ".txt"

input = [line.rstrip() for line in open(path, 'r').readlines()]
#endregion

# thank you, fuglede: this was a nice shortcut
# https://github.com/fuglede/adventofcode/blob/master/2023/day02/solutions.py
good_ids = total_power = 0
for line in input:
  parts = re.sub("[;,:]", "", line).split()
  colormax = defaultdict(int)
  for count, color in zip(parts[2::2], parts[3::2]):
    colormax[color] = max(colormax[color], int(count))
  if colormax["red"] <= 12 and colormax["green"] <= 13 and colormax["blue"] <= 14:
    good_ids += int(parts[1])
  total_power += math.prod(colormax.values())

#region answers
part1 = good_ids
if args.testing:
  test_value_part_1 = 8
  if part1 != test_value_part_1:
    print(Fore.RED + 'TEST VALUE IS WRONG: got {}, wanted {}'.format(part1, test_value_part_1))
  else:
    print(Fore.GREEN + 'Test 1: {}'.format(part1))
else:
  print(Fore.CYAN + '{}'.format(part1))

part2 = total_power
if args.testing:
  test_value_part_2 = 2286
  if part2 != test_value_part_2:
    print(Fore.RED + 'TEST VALUE IS WRONG: got {}, wanted {}'.format(part2, test_value_part_2))
  else:
    print(Fore.GREEN + 'Test 2: {}'.format(part2))
else:
  print(Fore.CYAN + '{}'.format(part2))
#endregion
