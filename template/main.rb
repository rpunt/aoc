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

def Part1(inputs)
  return 0
end

def Part2(inputs)
  return 0
end

part1 = Part1(inputs)
part2 = Part2(inputs)

puts "Part 1: #{part1}"
if $debug
  test_value_part_1 = 999
  if part1 != test_value_part_1
    puts "TEST VALUE IS WRONG: got #{part1}, wanted #{test_value_part_1}"
  end
end

puts "Part 2: #{part2}"
if $debug
  test_value_part_2 = 999
  if part2 != test_value_part_2
    puts "TEST VALUE IS WRONG: got #{part2}, wanted #{test_value_part_2}"
  end
end
