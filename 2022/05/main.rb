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

#     [D]
# [N] [C]
# [Z] [M] [P]
#  1   2   3

finished_stack_description = false
started_directions = false
boxes = []
directions = []
inputs.each do |line|
  if line.strip.empty?
    puts "found blank line, transitioning"
    finished_stack_description = true
    started_directions = true
    next
  end
  column_count = 0
  unless finished_stack_description
    puts "got box: #{line}"
    finished_stack_description = true if line.empty?
    column_count = line.length if line.length > column_count
    boxes << line
  end
  if started_directions
    puts "got directions: #{line}"
    directions << line
  end
end
require 'pry'; binding.pry
