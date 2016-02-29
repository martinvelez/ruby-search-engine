#!/usr/bin/env ruby



# TODO: Make this into a better command-line app

query = ARGF.read
search_engine = SearchEngine.new()
results = search_egine.search(query)
puts results
