Gem::Specification.new do |s|
	s.name = 'ruby-search-engine'
	s.version = '0.0.0'
	s.executables = ['ruby-search-engine']
	s.date = '2016-03-29'
	s.summary = "Search the web using Ruby"
	s.description = "Search the web using Ruby with this fast and lightweight gem."
	s.authors = ["Martin Velez", "Michael Yen", "Mathew Le"]
	s.email = ['marvelez@ucdavis.edu ', 'mkyen@ucdavis.edu', 'matle@ucdavis.edu']
	s.files = Dir["{lib,bin}/**/*"] + ["README.rdoc"]
	s.homepage = 'http://github.com/martinvelez/ruby-search-engine'
	s.require_paths = ["bin", "lib"]
	s.add_dependency('ruby_cli', '>=0.2.0')
end
