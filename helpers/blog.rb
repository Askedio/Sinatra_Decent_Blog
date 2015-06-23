module Sinatra
  module SimpleRubyBlog
    module Helpers

		def process_category new_post, cats
          new_post.categories.each do |cat|
            p cat
            p params[:category]
            puts cat.id
            if !params[:category].include?(cat.id.to_s)
					puts "destroy"
					#cat.post_categories.all.destroy
            end
          end

		  cats.each do |cat|
            category = Category.first(:id => cat)
            new_post.categories << category
          end	
		  new_post
		end


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