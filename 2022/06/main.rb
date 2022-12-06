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

def getMarker(windowsize, inputs)
  inputs = inputs[0].split('')
  inputs.each_with_index do |input,index|
    next if index < windowsize
    window = Array.new

    ((index - windowsize)..(index - 1)).each do |x|
      window.push(inputs[x])
    end
    next if window.uniq.length < windowsize
    return index if window.uniq.length == windowsize
  end
  return 999
end

def Part1(inputs)
  return getMarker(4, inputs)
end

def Part2(inputs)
  return getMarker(14, inputs)
end

part1 = Part1(inputs)
part2 = Part2(inputs)

puts "Part 1: #{part1}"
if $debug
  test_value_part_1 = 7
  if part1 != test_value_part_1
    puts "TEST VALUE IS WRONG: got #{part1}, wanted #{test_value_part_1}"
  end
end

puts "Part 2: #{part2}"
if $debug
  test_value_part_2 = 19
  if part2 != test_value_part_2
    puts "TEST VALUE IS WRONG: got #{part2}, wanted #{test_value_part_2}"
  end
end
