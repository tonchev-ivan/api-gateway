require 'dotenv'
require 'httparty'
require 'json'
require 'active_support/all'

# jwt could be used to make the request to banking
module Proxy
  class << self
    def proxy_request(request)
     begin
        response = HTTParty.send(request.env['REQUEST_METHOD'].downcase.to_sym,
          ENV["FIDOR_PATH"] + request.path,
          query: request.params,
          body: request.body.read.to_s,
          headers: get_headers(request.env))

        [response.code, response.body]
      rescue StandardError => e
        puts e.message
        puts e.backtrace
        [500, {error: e.message,
          headers: get_headers(request.env),
          body: request.body, params: request.params,
          path: request.path }.to_json
        ]
      end
    end

    private

    def get_headers(env)
      Hash[*env.select {|k,v| k.start_with?('HTTP_') || (k == 'CONTENT_TYPE') }
      .collect {|k,v| [k.sub(/^HTTP_/, ''), v]}
      .collect {|k,v| [k.split('_').collect(&:capitalize).join('-'), v]}
      .sort
      .flatten].except('Host', 'Connection', 'Version', 'X-Forwarded-For', 'X-Forwarded-Port', 'X-Forwarded-Proto')
    end
  end
end
