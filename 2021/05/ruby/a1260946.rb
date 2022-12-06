#!/usr/bin/env ruby
# frozen_string_literal: true

require './a1260946_classes'
require 'optimist'
require 'pry'

@options = Optimist.options do
  opt :inputfile, 'which inputfile should I use?', type: :string, default: ENV['USER'].downcase
  opt :testing, 'use testing inputs?', type: :bool, default: false
end
@options[:inputfile] = 'testable' if @options[:testing]

def read_inputs
  # inputs = File.read("../inputs/#{options[:inputfile]}.txt").split.map{|line| line.chars.map(&:to_i)}
  File.open("#{__dir__}/../inputs/#{@options[:inputfile]}.txt").map(&:chomp)
end

# coords are the original inputs forms, e.g. "0,9 -> 5,9"
# convert them to Points, e.g. [[0, 9], [5, 9]]
def coords_to_points(coords)
  points = []
  coords.split(' -> ').each do |coord|
    (origin, terminus) = coord.split(',').map(&:to_i)
    points << Point.new(origin, terminus)
  end

  points
end

def get_upper_bounds(lines)
  high_x = 0
  high_y = 0
  lines.each do |line|
    line.points.each do |point|
      high_x = point.x if point.x > high_x
      high_y = point.y if point.y > high_y
    end
  end

  [high_x, high_y]
end

# create a 0-filled X by Y array
def create_empty_matrix(width, depth)
  Array.new(width) { |_z| z = Array.new(depth, 0) }
end

def mark_matrix(lines, upper_bounds)
  matrix = create_empty_matrix(upper_bounds.first + 1, upper_bounds.last + 1)
  lines.each do |line|
    line.points.each do |point|
      matrix[point.x][point.y] += 1
    end
  end

  matrix
end

def count_overlaps(matrix)
  count = 0
  matrix.each do |line|
    line.each do |point|
      count += 1 if point >= 2
    end
  end

  count
end

def find_2line_overlaps
  lines = []
  read_inputs.each do |coords|
    points = coords_to_points(coords)
    line = Line.new(points.first, points.last)
    next unless line.horizontal || line.vertical
    lines << line
  end
  # lower_bounds = [0,0]
  upper_bounds = get_upper_bounds(lines)
  marked_matrix = mark_matrix(lines, upper_bounds)

  count_overlaps(marked_matrix)
end

def find_all2line_overlaps
  lines = []
  read_inputs.each do |coords|
    points = coords_to_points(coords)
    line = Line.new(points.first, points.last)
    lines << line
  end
  # lower_bounds = [0,0]
  upper_bounds = get_upper_bounds(lines)
  marked_matrix = mark_matrix(lines, upper_bounds)

  count_overlaps(marked_matrix)
end

puts "part 1: #{find_2line_overlaps}"
puts "part 2: #{find_all2line_overlaps}"
