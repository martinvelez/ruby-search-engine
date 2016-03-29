require 'json'
require 'open-uri'
# require 'ruby_cli'

class SearchEngine
  attr_accessor :uri, :results


  def initialize
    self.uri = "http://www.google.com/uds/GwebSearch?start=0&"\
                "rsz=large&hl=en&key=notsupplied&v=1.0&"
    self.results = []
  end


  def search(query, *fields, page: 1, top: 8 * fields.size)
    if query.empty?
      abort "Error: No query supplied."
    end

    if page.is_a? Integer
      set_page(page)
      hash_results = get_hash(query)
      get_results(fields, hash_results, top)
          
    elsif page.is_a? String
      if top == 8 * fields.size
        top = 8 * page[2 .. page.size].to_i
      end
    
      for i in page[0].to_i .. page[2 .. page.size].to_i
        # puts i
        set_page(i)
        hash_results = get_hash(query)
        get_results(fields, hash_results, top)
      end
    end
  
    if top > results.size and top > 8 * fields.size
      abort "The search does not have that many top results.\n"\
            "Please try again with top parameter <= #{results.size}"
    end
    
    return results.take(top)
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
  
  
  def no_fields_error(hash_results)
    puts "Error: No fields given. Your options are: "
    
    hash_results[0].keys.each do |hr_keys|
      puts "\t#{hr_keys}"
    end
    
    $stdout.sync = true
    abort
  end


  def get_uri(query)
    query.strip!
    q_uri = URI.encode_www_form('q' => query)
    return self.uri + q_uri + "&filter=1"
  end
  
  
  def get_results(fields, hash_results, top)
    if fields.empty?
      no_fields_error(hash_results)
      
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
      abort "Error: Page is out of bounds"
    end
    
    return results_hash[:responseData][:results]
  end
end