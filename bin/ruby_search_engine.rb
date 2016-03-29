#!/usr/bin/env ruby

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib','search_engine.rb'))
require 'ruby_cli'


query = ARGV.join(" ") # ARGF.read
search_engine = SearchEngine.new

results = search_engine.search(query, :url, pages: 2)
# results = search_engine.search(query, :url, :titleNoFormatting)
# results = search_engine.search(query, :url, :titleNoFormatting, pages: 2)

# puts search_engine.get_result_count(query)
# puts search_engine.get_search_time(query)
# puts search_engine.get_uri(query)
puts results
# puts results.size