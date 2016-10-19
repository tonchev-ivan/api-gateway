require 'sinatra/base'
require_relative 'lib/proxy.rb'

class ApplicationController < Sinatra::Base
  get "/*" do
    Proxy.proxy_request request
  end

  post "/*" do
    Proxy.proxy_request request
  end

  put "/*" do
    Proxy.proxy_request request
  end

  delete "/*" do
    Proxy.proxy_request request
  end
end
