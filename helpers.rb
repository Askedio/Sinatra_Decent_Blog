module Sinatra
  module SimpleRubyBlog
    module Helpers
		 
		 def protected!
		  return if authorized?
		  headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
		  halt 401, "Not authorized\n"
		end

		def authorized?
		  @auth ||=  Rack::Auth::Basic::Request.new(request.env)
		  @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin', 'admin']
		end




    end
  end
end