#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optimist'
require 'pry'

@options = Optimist.options do
  opt :inputfile, 'which inputfile should I use?', type: :string, default: ENV['USER'].downcase
  opt :testing, 'use testing inputs?', type: :bool, default: false
end
@options[:inputfile] = 'testable' if @options[:testing]

def read_inputs
  # inputs = File.read("../inputs/#{options[:inputfile]}.txt").split.map{|line| line.chars.map(&:to_i)}
  File.read("#{__dir__}/../inputs/#{@options[:inputfile]}.txt").split(',').map(&:to_i)
end

def simulate_spawn(days)
  fishes = {}
  fishes[0] = {}
  (0..8).each do |i|
    fishes[0][i] = 0
  end

  read_inputs.each do |age|
    fishes[0][age] += 1
  end

  (1..days).each do |day|
    fishes[day] ||= {}
    fishes[day][8] = fishes[day - 1][0]
    fishes[day][7] = fishes[day - 1][8]
    fishes[day][6] = fishes[day - 1][7]
    fishes[day][6] += fishes[day - 1][0]
    fishes[day][5] = fishes[day - 1][6]
    fishes[day][4] = fishes[day - 1][5]
    fishes[day][3] = fishes[day - 1][4]
    fishes[day][2] = fishes[day - 1][3]
    fishes[day][1] = fishes[day - 1][2]
    fishes[day][0] = fishes[day - 1][1]
  end

  count = 0
  fishes[fishes.keys.max].each_value do |v|
    count += v
  end

  count
end

puts "part 1: #{simulate_spawn(80)}"
puts "part 2: #{simulate_spawn(256)}"
