__DIR__ = File.dirname(__FILE__)
$: << __DIR__
RAILS_ROOT = __DIR__ unless defined?(RAILS_ROOT)

require 'test/unit'
require 'active_record'
ActiveRecord::Base.establish_connection :adapter  => 'sqlite3',
                                        :database => ':memory:'

require 'pretty_tests'
require 'silence'
require File.join(__DIR__,'..','lib','can_has_permalink')
