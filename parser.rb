require 'bundler/setup'
require 'dry/cli'
require 'pry'

##
# Require hacks
Dir['./hacks/*.rb'].sort.each { |file| require file }

##
# Require here parser classes
require_relative './percona/percona'

##
# Define parser class name
PARSER_CLASSES = [Percona::YumVersionFinder].freeze
