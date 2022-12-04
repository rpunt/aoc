#!/usr/bin/env ruby

require 'optimist'

options = Optimist::options do
  opt :inputfile, "which inputfile should I use?", :type => :string, :default => ENV['USER'].downcase
  opt :testing, "use testing inputs?", :type => :bool, :default => false
end

$debug = false
if options[:testing]
  options[:inputfile] = 'testable'
  $debug = true
end

inputs = []
File.open("#{__dir__}/../inputs/#{options[:inputfile]}.txt").each { |line| inputs << line.chomp }

def setup
  $priority_values = {}
  index = 1
  ('a'..'z').each do |letter|
    $priority_values[letter] = index
    index += 1
  end
  ('A'..'Z').each do |letter|
    $priority_values[letter] = index
    index += 1
  end
end

def halvsies(rucksack)
  [rucksack[0, rucksack.size/2], rucksack[rucksack.size/2..-1]]
end

def intersection(compartment1, compartment2)
  compartment1.split('') & compartment2.split('')
end

def group_intersection(group)
  group[0].split('') & group[1].split('') & group[2].split('')
end

def score_duplicates(common_items)
  total_points = 0
  common_items.each do |item|
    total_points += $priority_values[item]
  end

  total_points
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
  points = 0
  inputs.each do |rucksack|
    (compartment1, compartment2) = halvsies(rucksack)
    commons = intersection(compartment1, compartment2)
    points += score_duplicates(commons)
  end

  points
end

def Part2(inputs)
  points = 0
  groups = split_groups(inputs)
  require 'pry'; binding.pry
  groups.each do |group|
    commons = group_intersection(group)
    points += score_duplicates(commons)
  end

  points
end

setup
part1 = Part1(inputs)
part2 = Part2(inputs)

puts "Part 1: #{part1}"
if $debug
  test_value_part_1 = 157
  if part1 != test_value_part_1
    puts "TEST VALUE IS WRONG: got #{part1}, wanted #{test_value_part_1}"
  end
end

puts "Part 2: #{part2}"
if $debug
  test_value_part_2 = 70
  if part2 != test_value_part_2
    puts "TEST VALUE IS WRONG: got #{part2}, wanted #{test_value_part_2}"
  end
end
