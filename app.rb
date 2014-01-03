#!/usr/bin/env ruby

require_relative 'lib/record_parser'
require_relative 'lib/record_printer'

if ARGV.empty?
  $stderr.puts "./app.rb <file> [<file>, ...]" 
  exit 1
end

files = ARGV
all_rows = ARGV.inject([]) do |rows, file|
  parser = RecordParser.new(file)
  rows += parser.parse
end

print_order = %w(LastName FirstName Gender DateOfBirth FavoriteColor)

puts "By Gender asending then LastName descending"
sorted_rows = RecordSorter.new(all_rows).sort([[:Gender, :asc], [:LastName, :asc]])
puts RecordPrinter.new(sorted_rows).print(*print_order)
puts

puts "By DateOfBirth ascending"
sorted_rows = RecordSorter.new(all_rows).sort([[:LastName, :desc]])
puts RecordPrinter.new(sorted_rows).print(*print_order)
puts

puts "By LastName descending"
sorted_rows = RecordSorter.new(all_rows).sort([[:LastName, :desc]])
puts RecordPrinter.new(sorted_rows).print(*print_order)
puts
