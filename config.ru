require 'rack'
require 'sinatra'
require 'dotenv'
require_relative 'app.rb'
require_relative 'filters/simple_filter.rb'

Dotenv.load

# proxy application
run App

# filters for validating the request, params, headers, ip, privileges, etc
run SimpleFilter
