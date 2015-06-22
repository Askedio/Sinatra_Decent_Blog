module Sinatra
  module SimpleRubyBlog
    module Routing
      module BlogAdmin

		def self.registered(app)

			  app.get '/create' do 
				protected!
				erb :"admin/post/create" 
			  end

			  app.post '/create' do
				protected!
				image = ''
				if !params['myfile'].nil?
					accepted_formats = [".jpg", ".png", ".gif"]
					if !accepted_formats.include? File.extname(params['myfile'][:filename]) 
					 halt 500
					end
					File.open('public/assests/images/' + params['myfile'][:filename], "wb") do |f|
						f.write(params['myfile'][:tempfile].read)
						image = '/images/' + params['myfile'][:filename]
					end
				end
				
				person ||= Person.first(:name => session[:username]) || halt(404)
				new_post = person.posts.new(:title => params[:title], :slug => params[:title].slugify, :body => params[:body], :image => image)

				if new_post.save
				  redirect '/'
				else
				  do_error new_post.errors
				  redirect "/create"
				end
			  end

			  app.post '/edit/:id' do
				protected!
				##person ||= Person.first(:name => params[:poster])|| halt(404)
				post ||= Post.get(params[:id]) || halt(404)
				if post.update(:title => params[:title], :slug => params[:title].gsub(/<\/?[^>]*>/, "").slugify, :body => params[:body], :image => params[:myfile])
				  redirect '/'
				else
					do_error post.errors
					redirect "/edit/#{params[:id]}"
				end
			  end

			  app.get '/edit/:id' do
				protected!
				post ||= Post.get(params[:id]) || halt(404)
				@post = post
				erb :"admin/post/create" 
			  end

			  app.get '/delete/:id' do
				protected!
				post ||= Post.get(params[:id]) || halt(404)
				halt 500 unless post.destroy
				redirect '/'
			  end
		  end
	   end
    end
  end
end