require 'rack'
require 'sinatra'
require 'dotenv'
require_relative 'application_controller.rb'
require_relative 'filters/simple_filter.rb'

Dotenv.load

# filters for validating the request, params, headers, ip, privileges, etc
use SimpleFilter

# main proxy application
run ApplicationController
