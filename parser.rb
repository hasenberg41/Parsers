require 'bundler/setup'
require 'dry/cli'
require 'pry'

# requires all files recursively inside a directory from current dir
# @param _dir can be relative path like '/lib' or "../lib"
def require_all(dir)
  Dir[
    "#{File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), dir))}/**/*.rb"
  ].each do |file|
    require file
  end
end

##
# Require hacks
require_all 'hacks'

##
# Require here parser classes
# TODO: create rake generator
require_relative './percona/percona'

##
# Define parser class name
PARSER_CLASSES = [Percona::YumVersionFinder].freeze
