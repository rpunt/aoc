#!/usr/bin/env ruby

require 'optimist'
require 'colorize'

options = Optimist::options do
  opt :inputfile, "which inputfile should I use?", :type => :string, :default => 'input'
  opt :testing, "use testing inputs?", :type => :bool, :default => false
end

$debug = false
if options[:testing]
  options[:inputfile] = 'testable'
  $debug = true
end

inputs = File.read("#{__dir__}/#{options[:inputfile]}.txt").split

def Part1(inputs)
  return 0
end

def Part2(inputs)
  return 0
end

part1 = Part1(inputs)
part2 = Part2(inputs)

if $debug
  test_value_part_1 = 8
  if part1 != test_value_part_1
    puts "TEST VALUE IS WRONG: got #{part1}, wanted #{test_value_part_1}".red
  else
    puts "Part 1: success".green
  end
else
  puts "Part 1: #{part1}"
end

if $debug
  test_value_part_2 = 999
  if part2 != test_value_part_2
    puts "TEST VALUE IS WRONG: got #{part2}, wanted #{test_value_part_2}".red
  else
    puts "Part 2: success".green
  end
else
  puts "Part 2: #{part2}"
end
