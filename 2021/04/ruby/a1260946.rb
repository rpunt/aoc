#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optimist'

options = Optimist.options do
  opt :inputfile, 'which inputfile should I use?', type: :string, default: ENV['USER'].downcase
  opt :testing, 'use testing inputs?', type: :bool, default: false
end
options[:inputfile] = 'testable' if options[:testing]

def make_boards(input)
  boards = []
  board = 0
  input.each_with_index do |line, idx|
    next if idx < 2
    boards[board] ||= []
    if line == ''
      # blank line? we've got a new board
      board += 1
    else
      boards[board] << line.split(' ').map(&:to_i)
    end
  end

  boards
end

def winner?(board)
  filled_rows = board.any? { |row| row.compact.empty? }
  filled_columns = board.transpose.any? { |row| row.compact.empty? }
  return filled_rows || filled_columns
end

def sum_board(board, lastcalled)
  return board.flatten.compact.reduce(:+) * lastcalled
end

def play_game(boards, picked_numbers)
  picked_numbers.each do |drawn_number|
    boards.each_index do |board|
      boards[board].each_index do |row|
        boards[board][row].each_index do |column|
          boards[board][row][column] = nil if boards[board][row][column] == drawn_number
        end
      end
      return sum_board(boards[board], drawn_number) if winner?(boards[board])
    end
  end
end

def let_the_squid_win(boards, picked_numbers)
  board_score = 0
  picked_numbers.each do |drawn_number|
    boards.each_index do |board|
      boards[board].each_index do |row|
        boards[board][row].each_index do |column|
          boards[board][row][column] = nil if boards[board][row][column] == drawn_number
        end
      end
      board_score = sum_board(boards[board], drawn_number) if winner?(boards[board])
    end
    boards.each_with_index { |board, ndx| boards.delete_at(ndx) if winner?(boards[ndx]) }
  end
  return board_score
end

# inputs = File.read("../inputs/#{options[:inputfile]}.txt").split.map{|line| line.chars.map(&:to_i)}
inputs = []
File.open("#{__dir__}/../inputs/#{options[:inputfile]}.txt").each { |line| inputs << line.chomp }

picked_numbers = inputs.first.split(',').map(&:to_i)

boards = make_boards(inputs)
puts "part 1: #{play_game(boards, picked_numbers)}"
boards = make_boards(inputs)
puts "part 2: #{let_the_squid_win(boards, picked_numbers)}"
