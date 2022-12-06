#!/usr/bin/env ruby

require 'optimist'

options = Optimist::options do
  opt :inputfile, "which inputfile should I use?", :type => :string, :default => ENV['USER'].downcase
  opt :testing, "use testing inputs?", :type => :bool, :default => false
end
options[:inputfile] = 'testable' if options[:testing]

increases = 0
$inputs = []
File.open("#{__dir__}/../inputs/#{options[:inputfile]}.txt").each { |line| $inputs << line.chomp }

#
## part 1
#
$inputs.each_with_index do |input,index|
  next if index == 0
  increases += 1 if $inputs[index] > $inputs[index - 1]
end

puts "increases: #{increases}"

#
## part 2
#
def gettriple(ndx)
  return $inputs[ndx - 1] + $inputs[ndx] + $inputs[ndx + 1]
end

increases = 0

$inputs.each_with_index do |input,index|
  next if index == 0
  next if index == $inputs.index($inputs.last)
  increases += 1 if gettriple(index) > gettriple(index - 1)
end

puts "windowed increases: #{increases}"
