require 'simplecov'
require 'coveralls'
SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start 'test_frameworks'

require "minitest/autorun"
require "minitest/spec"
