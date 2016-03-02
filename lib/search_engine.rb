require 'google-search'

class SearchEngine
  def initialize
    @mySearch = Google::Search::Web.new
  end

  def search(query)
    @mySearch = Google::Search::Web.new do |searcher|
    searcher.query = query
    searcher.each_response { print '.'; $stdout.flush } # or STDOUT.sync = true
    end
    
    return @mySearch.get_uri # stored as JSON, how to get URLS?
  end

end


query = "C++ how to initialize array"
search_engine = SearchEngine.new()
results = search_engine.search(query)
puts results