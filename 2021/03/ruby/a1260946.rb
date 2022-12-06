#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optimist'
require 'matrix'

options = Optimist.options do
  opt :inputfile, 'which inputfile should I use?', type: :string, default: ENV['USER'].downcase
  opt :testing, 'use testing inputs?', type: :bool, default: false
end
options[:inputfile] = 'testable' if options[:testing]

# create a frequency hash map for a given array
def make_frequency_map(vector)
  vector.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
end

# a function to find the most common element in an array via a frequency hash map
def mostcommon(vector, frequency_map)
  mc = frequency_map.key(frequency_map.values.max)
  mc = 1 if frequency_map.values.first == frequency_map.values.last

  mc
end

# a function to find the least common element in an array via a frequency hash map
def leastcommon(vector, frequency_map)
  lc = frequency_map.key(frequency_map.values.min)
  lc = 0 if frequency_map.values.first == frequency_map.values.last

  lc
end

def filterMostCommon(matrix, keep_most_common = true, index = 0)
  keepers = []
  frequency_map = make_frequency_map(matrix.column_vectors[index])
  matrix.row_vectors.each do |vector|
    mc = mostcommon(vector, frequency_map)
    lc = leastcommon(vector, frequency_map)
    if keep_most_common
      keepers.push(vector) if vector[index] == mc
    else
      keepers.push(vector) if vector[index] == lc
    end
  end

  keeper_matrix = Matrix[*keepers]

  return keeper_matrix if keeper_matrix.row_count == 1

  filterMostCommon(keeper_matrix, keep_most_common, index + 1)
end

inputs = File.read("#{__dir__}/../inputs/#{options[:inputfile]}.txt").split.map{|line| line.chars.map(&:to_i)}

mat = Matrix[*inputs]

gamma = []
epsilon = []

mat.column_vectors.each do |vector|
  frequency_map = make_frequency_map(vector)
  gamma.push(mostcommon(vector, frequency_map))
  epsilon.push(leastcommon(vector, frequency_map))
end
puts "part 1: #{gamma.join.to_i(2) * epsilon.join.to_i(2)}"

o2 = filterMostCommon(mat, true)
co2 = filterMostCommon(mat, false)

puts "part 2: #{o2.row(0).to_a.join.to_i(2) * co2.row(0).to_a.join.to_i(2)}\n\tO2:  #{o2.row(0).to_a.join} (#{o2.row(0).to_a.join.to_i(2)})\n\tCO2: #{co2.row(0).to_a.join} (#{co2.row(0).to_a.join.to_i(2)})"
