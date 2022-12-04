#!/usr/bin/env ruby

require 'optimist'

options = Optimist::options do
  opt :inputfile, "which inputfile should I use?", :type => :string, :default => 'input'
  opt :testing, "use testing inputs?", :type => :bool, :default => false
end

$debug = false
if options[:testing]
  options[:inputfile] = 'testable'
  $debug = true
end

inputs = []
File.open("#{__dir__}/#{options[:inputfile]}.txt").each { |line| inputs << line.chomp }

def makeRange(min, max)
  range = []
  (min..max).each do |ndx|
    range.append(ndx)
  end

  range
end

def intersection(section1, section2)
  section1 & section2
end

def split_groups(inputs)
  groups = []
  group = []
  inputs.each do |rucksack|
    group << rucksack
    if group.length == 3
      groups << group.dup
      group.clear
    end
  end

  groups
end

def Part1(inputs)
  fully_contained = 0
  inputs.each do |sections|
    one, two = sections.split(",")
    onemin, onemax = one.split("-")
    range1 = makeRange(onemin, onemax)
    twomin, twomax = two.split("-")
    range2 = makeRange(twomin, twomax)
    intersect = intersection(range1, range2)
    fully_contained += 1 if intersect == range1 || intersect == range2
  end

  fully_contained
end

def Part2(inputs)
  intersected = 0
  inputs.each do |sections|
    one, two = sections.split(",")
    onemin, onemax = one.split("-")
    range1 = makeRange(onemin, onemax)
    twomin, twomax = two.split("-")
    range2 = makeRange(twomin, twomax)
    intersected += 1 if intersection(range1, range2).length > 0
  end

  intersected
end

# setup
part1 = Part1(inputs)
part2 = Part2(inputs)

puts "Part 1: #{part1}"
if $debug
  test_value_part_1 = 2
  if part1 != test_value_part_1
    puts "TEST VALUE IS WRONG: got #{part1}, wanted #{test_value_part_1}"
  end
end

puts "Part 2: #{part2}"
if $debug
  test_value_part_2 = 4
  if part2 != test_value_part_2
    puts "TEST VALUE IS WRONG: got #{part2}, wanted #{test_value_part_2}"
  end
end
