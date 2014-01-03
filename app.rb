#!/usr/bin/env ruby

require_relative 'lib/record_parser'
require_relative 'lib/record_printer'

parser = RecordParser.new(ARGV[0])
print_order = %w(LastName FirstName Gender DateOfBirth FavoriteColor)

puts "By Gender asendingc then LastName descending"
rows = parser.parse(:sort => [[:Gender, :asc], [:LastName, :asc]])
puts RecordPrinter.new(rows).print(*print_order)
puts

puts "By DateOfBirth ascending"
rows = parser.parse(:sort => [[:LastName, :desc]])
puts RecordPrinter.new(rows).print(*print_order)
puts

puts "By LastName descending"
rows = parser.parse(:sort => [[:LastName, :desc]])
puts RecordPrinter.new(rows).print(*print_order)
puts
