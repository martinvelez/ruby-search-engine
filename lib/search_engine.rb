require 'google-search'
require 'json'
# require 'active_support'
# require 'ruby_cli'

class SearchEngine
  attr_accessor :uri, :results

  def initialize
    self.uri = 'http://www.google.com/uds/GwebSearch?start=0&rsz=large&hl=en&key=notsupplied&v=1.0&'
    self.results = []
  end

  def search(query, *fields)
    # options = fields.extract_options!
    # puts "Arguments:  #{fields.inspect}"
    # puts "Options:    #{options.inspect}"
    
    if query.empty?
      abort("Error: No query supplied")
    end
    
    file = open(get_uri(query))
    my_hash = JSON.parse(file.read)
		hash_results = my_hash["responseData"]["results"]

    if fields.empty?
      puts "No fields given"
      puts "Your options are #{hash_results[0].keys}"

    elsif fields.include? "all"
      hash_results[0].keys.each do |hr_keys|
        index = 0
        hash_results.each do |hr|
  				results << hash_results[index][hr_keys]
  				index += 1
  		  end
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