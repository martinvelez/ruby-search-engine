require 'google-search'
require 'json'
# require 'ruby_cli'

class SearchEngine
  attr_accessor :uri, :results

  def initialize
    self.uri = 'http://www.google.com/uds/GwebSearch?start=0&rsz=large&hl=en&key=notsupplied&v=1.0&'
    self.results = []
  end

  def search(query, *fields)
    if query.empty?
      abort "Error: No query supplied"
    end
    
    file = open(get_uri(query))
    my_hash = JSON.parse(file.read)
		hash_results = my_hash["responseData"]["results"]

    if fields.empty?
      puts "Error: No fields given. Your options are: "
    
      hash_results[0].keys.each do |hr_keys|
        puts "\t#{hr_keys}"
      end
      
      $stdout.sync = true
      abort
      
    elsif fields.include? "all" and fields.length > 1
  	  abort "Error: Either use \"all\" or the options"
  	  
    elsif fields.include? "all"
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

  def get_uri(query)
    query.strip!
    q_uri = URI.encode_www_form( 'q' => query )
    return self.uri + q_uri + "&filter=1"
  end
end