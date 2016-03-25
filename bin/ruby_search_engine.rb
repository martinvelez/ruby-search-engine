#!/usr/bin/env ruby

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib','search_engine.rb'))


# ruby_cli?
query = ARGV.join(" ") # ARGF.read
search_engine = SearchEngine.new

# results = search_engine.search(query)

# results = search_engine.search(query, "url")
results = search_engine.search(query, "url", page: 2)

# results = search_engine.search(query, "url", "titleNoFormatting")
# results = search_engine.search(query, "url", "titleNoFormatting", page: 1)

# results = search_engine.search(query, "all")


# puts search_engine.get_uri(query)
puts results