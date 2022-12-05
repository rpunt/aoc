#!/usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'
require 'time'
require 'optimist'
require 'httparty'
require 'fileutils'

today = Time.new

options = Optimist.options do
  opt :year, 'data: target year', type: :integer, default: today.year
  opt :day, 'data: target day', type: :integer, default: today.day
end

abort('2020 is the earliest year supported at this time') if options[:year] < 2020

# A function to download test data and problemsets for adventofcode
#
# @param year [Integer] the year in which the problem was presented
# @param day [Integer] the day of the year in which the problem was presented
#
# @return [String]
def getdata(year, day)
  # return HTTP response body for the chosen year and day
  response = HTTParty.get("https://adventofcode.com/#{year}/day/#{day}")
  case response.code
  when 200
    response.body
  when 404
    abort('Page not found')
  end
end

# A function to write data to a path, creating required paths along the way
#
# @param path [String] the path to which the data should be written, including filename
# @param data [String] the data to be written
#
# @return [void]
def writedata(path, data)
  FileUtils.mkdir_p(File.dirname(path))
  File.write(path, data)
end

# set the xpath selectors appropriate for the year in question
xpath_selector = {
  2022 => {
    'parent_readme' => '//article',
    'testdata' => 'pre//code'
  },
  2021 => {
    'parent_readme' => '//article',
    'testdata' => '//pre/code'
  },
  2020 => {
    'parent_readme' => '//article',
    'testdata' => '//pre/code'
  }
}

data = Nokogiri::HTML.parse(getdata(options[:year], options[:day]))

# parent_readme_data = data.xpath(xpath_selector[options[:year]]['parent_readme']).text
#                          .gsub(/\n/, "\n\n")
#                          .gsub(/^---/, '#')
#                          .gsub(/ ---/, "\n\n## Part 1\n\n")
testable_inputs_data = data.xpath(xpath_selector[options[:year]]['testdata']).text

writedata(
  "#{File.expand_path('../', __FILE__)}/../#{options[:year]}/#{'%02d' % options[:day]}/testable.txt",
  testable_inputs_data
)
writedata(
  "#{File.expand_path('../', __FILE__)}/../#{options[:year]}/#{'%02d' % options[:day]}/main.go",
  File.read("#{File.expand_path('../', __FILE__)}/../template/main.go")
)
writedata(
  "#{File.expand_path('../', __FILE__)}/../#{options[:year]}/#{'%02d' % options[:day]}/main_test.go",
  File.read("#{File.expand_path('../', __FILE__)}/../template/main_test.go")
)
