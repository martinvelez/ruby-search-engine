#!/usr/bin/env ruby

require 'ruby-search-engine'


# TODO: Make this into a better command-line app

query = ARGF.read
search_engine = SearchEngine.new()
results = search_egine.search(query)
puts results
