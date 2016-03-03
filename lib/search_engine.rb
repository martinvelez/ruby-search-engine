require 'google-search'

class SearchEngine

	def initialize
	
	end

	def search(query)
		results = []
		
		# TODO: Replace with our own code
		Google::Search::Web.new do |search|
			search.query = query
			search.size = :large
		end.each { |item| results << item }

		return results
	end

end

