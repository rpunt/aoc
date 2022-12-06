#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optimist'

options = Optimist.options do
  opt :inputfile, 'which inputfile should I use?', type: :string, default: ENV['USER'].downcase
  opt :testing, 'use testing inputs?', type: :bool, default: false
end
options[:inputfile] = 'testable' if options[:testing]

crabs = File.read("#{__dir__}/../inputs/#{options[:inputfile]}.txt").split(',').map{ |s| s.to_i}.sort

def linear_sum(n)
  return (n*(n+1))/2
end

distances = {}
S = {}
for possible_distance in (crabs.min..crabs.max) do
  distances[possible_distance] = 0
  S[possible_distance] = 0
  for crab in crabs do
    position_delta = (crab - possible_distance).abs
    distances[possible_distance] += position_delta
    S[possible_distance] += linear_sum(position_delta)
  end
end

puts "Part 1: #{distances.key(distances.values.min)} moves, #{distances.values.min} fuel"
puts "Part 2: #{S.key(S.values.min)} moves, #{S.values.min} fuel"
