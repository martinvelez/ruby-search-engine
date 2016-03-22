require 'google-search'
require 'json'
# require 'ruby_cli'

class SearchEngine
  attr_accessor :uri, :results

  def initialize
    self.uri = 'http://www.google.com/uds/GwebSearch?start=0&rsz=large&hl=en&key=notsupplied&v=1.0&'
    self.results = []
  end

  def search(query, fields = [])
    #####################################################

    # TODO: Replace with our own code
    # se = Google::Search::Web.new do |search|
    #   search.query = query
    #   search.size = :large
    # end
    
    # # puts se.inspect
    # puts se.get_uri
    # se.each { |item| results << item }
    
    #####################################################
   
    file = open(get_uri(query))
    my_hash = JSON.parse(file.read)

		puts '************************'	
		results = my_hash["responseData"]["results"]
		puts '************************'	

		if fields.size > 0
			new_results = []			
			fields.each do |f|
				results.each do |r|
					if !r.has_key(f)
						new_results << 
					end
				end
			end
		end


    results = SearchEngine::Results.new
    results.get_results(my_hash)
    
    return results
  end

  def get_uri(query)
    query.strip!
    q_uri = URI.encode_www_form( 'q' => query )
    return self.uri + q_uri + "&filter=1"
  end
  
  
  class Results
    attr_accessor :gsearchResultClass, :unescapedUrl, :url, :visibleUrl, 
    :cacheUrl, :title, :titleNoFormatting, :content
    
    def initialize
      @gsearchResultClass = []
      @unescapedUrl       = []
      @url                = []
      @visibleUrl         = []
      @cacheUrl           = []
      @title              = []
      @titleNoFormatting  = []
      @content            = []
    end
    
    def get_results(my_hash)
      hash_results = my_hash["responseData"]["results"]
      
      (0 .. my_hash["responseData"]["results"].size - 1).each do |index|
        @gsearchResultClass << hash_results[index]["GsearchResultClass"]
        @unescapedUrl       << hash_results[index]["unescapedUrl"]
        @url                << hash_results[index]["url"]
        @visibleUrl         << hash_results[index]["visibleUrl"]
        @cacheUrl           << hash_results[index]["cacheUrl"]
        @title              << hash_results[index]["title"]
        @titleNoFormatting  << hash_results[index]["titleNoFormatting"]
        @content            << hash_results[index]["content"]
      end
    end
  end
end
