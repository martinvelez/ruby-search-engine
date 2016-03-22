require 'google-search'
require 'json'
# require 'ruby_cli'

class SearchEngine
  attr_accessor :uri

  def initialize
    self.uri = 'http://www.google.com/uds/GwebSearch?start=0&rsz=large&hl=en&key=notsupplied&v=1.0&'
  end

  def search(query)
    results = []
    
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

    (0 .. my_hash["responseData"]["results"].size - 1).each do |index|
      results << my_hash["responseData"]["results"][index]["url"]
    end

    return results
  end

  def get_uri(query)
    query.strip!
    q_uri = URI.encode_www_form( 'q' => query )
    return self.uri + q_uri + "&filter=1"
  end
end