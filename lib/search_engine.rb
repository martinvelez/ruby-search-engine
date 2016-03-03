require 'google-search'
require 

class SearchEngine

	attr_accessor :uri

	def initialize
		self.uri = 'http://www.google.com/uds/GwebSearch?start=0&rsz=large&hl=en&key=notsupplied&v=1.0&q='open+file+in+ruby%0A&filter=1
	end

	def search(query, num_of_pages=1)
		results = []
		
		# TODO: Replace with our own code
		se = Google::Search::Web.new do |search|
			search.query = query
			search.size = :large
		end
		puts se.inspect
		puts se.get_uri
		se.each { |item| results << item }

		return results
	end

	def get_uri(query)
		query.strip!
		# TODO url encode query
		self.uri + query + '&filter=1'	
	end

end

=begin
query = "C++ how to initialize array"
search_engine = SearchEngine.new()
results = search_engine.search(query)
puts results
=end
