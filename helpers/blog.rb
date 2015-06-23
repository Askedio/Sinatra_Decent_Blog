module Sinatra
  module SimpleRubyBlog
    module Helpers

		def do_error data
			error = nil
			data.each do |e|
			 error = "#{error}  #{e}"
			end
			flash[:error] = error
		end
		 
		 def protected!

		  return if auth?
		  headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
		  halt 401, "Not authorized\n"
		end

		def auth?
		  @auth ||=  Rack::Auth::Basic::Request.new(request.env)
			if @auth.provided? && @auth.basic? && @auth.credentials
			   user = Person.first(:name => @auth.credentials[0])
			end
			if user && user.password == @auth.credentials[1]
			  session[:username] = user.name
			  return true
			else
			  response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
			  throw(:halt, [401, "Not authorized\n"])
			end
		end


		def authorized?
		  @auth ||=  Rack::Auth::Basic::Request.new(request.env)
			if @auth.provided? && @auth.basic? && @auth.credentials
			  return true
			else
			  return false
			end
		end




    end
  end
end