#!/usr/bin/env ruby

require_relative 'lib/record_parser'

parser = RecordParser.new(ARGV[0])

puts "By Gender asendingc then LastName descending"
puts parser.parse(:sort => [[:Gender, :asc], [:LastName, :asc]])
puts

puts "By DateOfBirth ascending"
puts parser.parse(:sort => [[:LastName, :desc]])
puts

puts "By LastName descending"
puts parser.parse(:sort => [[:LastName, :desc]])
