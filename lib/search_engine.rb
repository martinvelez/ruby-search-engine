require 'json'
require 'open-uri'

class SearchEngine
  attr_accessor :uri


  def initialize
    self.uri = "http://www.google.com/uds/GwebSearch?start=0"\
               "&rsz=large&hl=en&key=notsupplied&v=1.0&"
  end


  def search(query, *fields, pages: 1)
    results = []
    raise "No query given" if query.empty?
    
    for i in 1..pages
			uri = build_url(query, i)
			file = open(uri)
    	my_hash = JSON.parse(file.read, symbolize_names: true)
      raise "Page is out of bounds" unless !my_hash[:responseData].nil?
			hash_results = my_hash[:responseData][:results]
      results << extract_fields(fields, hash_results)
    end
    
    return results
  end


	def build_url(query, page)
		start = (page - 1) * 8
    self.uri.chomp! "&rsz=large&hl=en&key=notsupplied&v=1.0&"
    
    while self.uri[-1, 1] != "=" do
      self.uri.chop!
    end
    
    self.uri << "#{start}&rsz=large&hl=en&key=notsupplied&v=1.0&"

		query.strip!
    q_uri = URI.encode_www_form('q' => query)

    return self.uri + q_uri + "&filter=1"
	end

  
  def extract_fields(fields, hash_results)
    extracted_results = []
    if fields.empty?
      raise "No fields given."
    else
      fields.each do |f|
        index = 0
        
        hash_results.each do |hr|
          if hr.has_key?(f)
            extracted_results << hash_results[index][f]
            index += 1
          end
        end
      end
    end
    
    return extracted_results
  end
  
  
  def get_result_count(query)
    cursor_hash = open_file(query)
    return cursor_hash[:responseData][:cursor][:resultCount]
  end
  
  
  def get_search_time(query)
    cursor_hash = open_file(query)
    return cursor_hash[:responseData][:cursor][:searchResultTime]
  end
  
end
