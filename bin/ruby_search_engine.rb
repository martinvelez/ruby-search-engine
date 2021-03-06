#!/usr/bin/env ruby

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib','search_engine.rb'))
require 'ruby_cli'

class App
	include RubyCLI

	def initialize_command_options
		@options = {:pages => 1}
	end
	def define_command_option_parsing
		@opt_parser.on('-p', '--pages RANGE', Integer, 'what pages you want') do |pages|
			@options[:pages] = pages
		end
	end	

	def command
		query = ARGV.join(" ")
		search_engine = SearchEngine.new
		
		begin
			results = search_engine.search(query, :url, pages: @options[:pages])
		rescue Exception => e
			puts e
		end
		
		puts results
	end

end

app = App.new(ARGV, __FILE__)
app.run
