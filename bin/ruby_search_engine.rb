#!/usr/bin/env ruby

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib','search_engine.rb'))


# ruby_cli?
query = ARGV.join(" ") # ARGF.read
search_engine = SearchEngine.new
results = search_engine.search(query)

puts search_engine.get_uri(query)
puts results





# results.each do |r|
# 	puts "#{r.index}\t#{r.title}\t#{r.uri}"
# end