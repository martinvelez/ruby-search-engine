Gem::Specification.new do |s|
	s.name = 'ruby-search-engine'
	s.version = '0.0.1'
	s.executables = ['ruby_search_engine.rb']
	s.date = '2016-03-29'
	s.summary = "Search the web using Ruby"
	s.description = "Search the web using Ruby with this fast and lightweight gem, made to prioritize speed and efficiency. Compared to other search gems, this aims to be minimal, easy to use and most importantly, quick. For any inquiries, please feel free to contact us via email or a pull request. I hope you enjoy using the ruby-search-engine as much as we have had while making it!
					\nhttps://github.com/martinvelez/ruby-search-engine \n-Matt Le"
	s.authors = ["Martin Velez", "Michael Yen", "Mathew Le"]
	s.email = ['marvelez@ucdavis.edu ', 'mkyen@ucdavis.edu', 'matle@ucdavis.edu']
	s.files = Dir["{lib,bin}/**/*"] + ["README.rdoc"]
	s.homepage = 'http://github.com/martinvelez/ruby-search-engine'
	s.require_paths = ["bin", "lib"]
	s.add_dependency('ruby_cli', '>=0.2.0')
	s.license = 'MIT'
end
