require 'rack'
require 'sinatra'
require_relative 'app.rb'
require 'dotenv'

Dotenv.load

run App
