require 'sinatra/base'

class SimpleFilter < Sinatra::Base

  before do
    content_type_filter
  end

  private

  def content_type_filter
    if content_type_correct?(request)
      pass
    else
      error 500 do
        'Bad request'
      end
    end
  end

  def content_type_correct?(request)
    request.accept.any? &&
      request.accept?(Sinatra::Request::AcceptEntry.new "application/vnd.fidor.de; version=1") &&
      request.accept?(Sinatra::Request::AcceptEntry.new "text/json")
  end
end
