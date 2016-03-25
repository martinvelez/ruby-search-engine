require 'google-search'
require 'json'
# require 'ruby_cli'

class SearchEngine
  attr_accessor :uri, :results

  def initialize
    self.uri = "http://www.google.com/uds/GwebSearch?start=0&rsz=large&hl=en&key=notsupplied&v=1.0&"
    self.results = []
  end

  def search(query, *fields, page: 1)
    set_page(page)

    if query.empty?
      abort "Error: No query supplied"
    end
    
    hash_results = get_hash(query)

    if fields.empty?
      no_fields_error(hash_results)
      
    elsif fields.include? :all and fields.length > 1
  	  abort "Error: Either use \"all\" or the options"
  	  
    elsif fields.include? :all
      get_all(hash_results)
      
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
    
    return results
  end

  def set_page(page)
    start = (page - 1) * 8
    self.uri.chomp! "&rsz=large&hl=en&key=notsupplied&v=1.0&"
    self.uri.chop!
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
    q_uri = URI.encode_www_form( 'q' => query )
    return self.uri + q_uri + "&filter=1"
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
		return results_hash[:responseData][:results]
  end
  
  def get_all(hash_results)
    hash_results[0].keys.each do |hr_keys|
      index = 0
      
      results << "--------------------"
      results << hr_keys
      results << "--------------------"
  
      hash_results.each do |hr|
				results << "#{index}. " + hash_results[index][hr_keys]
				index += 1
		  end
		  
		  results << "\n\n"
		end
  end
end