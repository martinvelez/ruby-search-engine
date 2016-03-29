require 'json'
require 'open-uri'

class SearchEngine
  attr_accessor :uri, :results


  def initialize
    self.uri = "http://www.google.com/uds/GwebSearch?start=0"\
               "&rsz=large&hl=en&key=notsupplied&v=1.0&"
    self.results = []
  end


  def search(query, *fields, pages: 1)
    if query.empty?
      raise "No query given"
    end
    
    for i in 1 .. pages
      set_page(i)
      hash_results = get_hash(query)
      get_results(fields, hash_results)
    end
    
    return results
  end


  def set_page(page)
    start = (page - 1) * 8
    self.uri.chomp! "&rsz=large&hl=en&key=notsupplied&v=1.0&"
    
    while self.uri[-1, 1] != "=" do
      self.uri.chop!
    end
    
    self.uri << "#{start}&rsz=large&hl=en&key=notsupplied&v=1.0&"
  end
  
  
  def open_file(query)
    file = open(get_uri(query))
    my_hash = JSON.parse(file.read, symbolize_names: true)
    return my_hash
  end


  def get_uri(query)
    query.strip!
    q_uri = URI.encode_www_form('q' => query)
    return self.uri + q_uri + "&filter=1"
  end
  
  
  def get_results(fields, hash_results)
    if fields.empty?
      raise "No fields given."
      
    else
      fields.each do |f|
        index = 0
        
        hash_results.each do |hr|
          if hr.has_key?(f)
            results << hash_results[index][f]
            index += 1
          end
        end
      end
    end
  end
  
  
  def get_result_count(query)
    cursor_hash = open_file(query)
    return cursor_hash[:responseData][:cursor][:resultCount]
  end
  
  
  def get_search_time(query)
    cursor_hash = open_file(query)
    return cursor_hash[:responseData][:cursor][:searchResultTime]
  end
  
  
  def get_hash(query)
    results_hash = open_file(query)
    
    if results_hash[:responseData].nil?
      raise "Page is out of bounds"
    end

    return results_hash[:responseData][:results]
  end
end