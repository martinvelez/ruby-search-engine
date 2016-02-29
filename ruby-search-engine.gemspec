Gem::Specification.new do |s|
	s.name = 'ruby-search-engine'
	s.version = '0.0.0'
	s.executables = ['ruby-search-engine']
	s.date = '2016-02-29'
	s.summary = "Search the web using Ruby"
	s.description = "Search the web using Ruby"
	s.authors = ["Martin Velez", "Michael Yen", "Matthew Le"]
	s.email = 'mvelez999@gmail.com'
	s.files = Dir["{lib,bin}/**/*"] + ["README.rdoc"]
	s.homepage = 'http://github.com/martinvelez/ruby-search-engine'
	s.require_paths = ["bin", "lib"]
	#s.add_dependency('ruby_cli', '>=0.2.0')
end
