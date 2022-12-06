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

# sample input
#     [D]
# [N] [C]
# [Z] [M] [P]
#  1   2   3

def columnize_boxes(inputs)
  finished_stack_description = false
  started_directions = false
  boxes = []
  directions = []
  column_width = 0
  column_count = 0

  inputs.each do |line|
    if line.strip.empty?
      # a blank line is the key to swap between boxes and directions
      finished_stack_description = true
      started_directions = true
      next
    end

    unless finished_stack_description
      finished_stack_description = true if line.empty?
      column_width = line.length if line.length > column_width
      boxes << line
    end

    if started_directions
      directions << line
    end
  end

  boxes.reject! { |line| line =~ /\s1\s\s\s2/ }
  boxes.reverse!
  rows = boxes.count
  column_count = (column_width + 1) / 4

  rows = {}
  columns = {}
  boxes.each_with_index do |box, index|
    box.chars.each_slice((column_width + 1) / column_count).map(&:join).each do |box|
      rows[index + 1] ||= []
      rows[index + 1] << box.gsub('[', '').gsub(']', '').gsub("\s", '')
    end
  end

  rows.each do |row_index, row|
    row.each_with_index do |box, box_index|
      next if box.nil? || box.empty?
      columns[box_index + 1] ||= []
      columns[box_index + 1] << box
    end
  end

  return columns, directions
end

def rearrange_single_boxes(columns, directions)
  directions.each do |direction|
    qty = direction.split(' ')[1].to_i
    src = direction.split(' ')[3].to_i
    dst = direction.split(' ')[5].to_i
    for x in 1..qty do
      box = columns[src].pop
      puts "moving #{box} from #{src} to #{dst}" if $debug
      columns[dst].push(box)
    end
  end

  return columns
end

def rearrange_multi_boxes(columns, directions)
  directions.each do |direction|
    qty = direction.split(' ')[1].to_i
    src = direction.split(' ')[3].to_i
    dst = direction.split(' ')[5].to_i
    tmp = []
    for x in 1..qty do
      box = columns[src].pop
      puts "moving #{box} from #{src} to #{dst}" if $debug
      tmp.push(box)
    end
    for x in 1..qty do
      box = tmp.pop
      puts "moving #{box} from #{src} to #{dst}" if $debug
      columns[dst].push(box)
    end
  end

  return columns
end

def column_tops(columns)
  tops = []
  columns.each do |_ndx, boxes|
    tops << boxes.pop
  end

  tops
end

def Part1(inputs)
  columns, directions = columnize_boxes(inputs)
  rearranged = rearrange_single_boxes(columns, directions)

  column_tops(rearranged).join
end

def Part2(inputs)
  columns, directions = columnize_boxes(inputs)
  rearranged = rearrange_multi_boxes(columns, directions)

  column_tops(rearranged).join
end

part1 = Part1(inputs)
part2 = Part2(inputs)

puts "Part 1: #{part1}"
if $debug
  test_value_part_1 = "CMZ"
  if part1 != test_value_part_1
    puts "TEST VALUE IS WRONG: got #{part1}, wanted #{test_value_part_1}"
  end
end

puts "Part 2: #{part2}"
if $debug
  test_value_part_2 = "MCD"
  if part2 != test_value_part_2
    puts "TEST VALUE IS WRONG: got #{part2}, wanted #{test_value_part_2}"
  end
end
