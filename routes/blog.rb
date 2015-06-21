 module Sinatra
  module SimpleRubyBlog
    module Routing
      module BlogAdmin
		def self.registered(app)

			  app.get '/create' do 
				protected!
				erb :create 
			  end

			  app.post '/create' do
				protected!
				new_post = Post.new(:title => params[:title], :slug => params[:title].slugify, :body => params[:body])
				if new_post.save
				  redirect '/'
				else
				  new_post.errors.each do |e|
				   puts e
				  end
				  halt 500
				end
			  end

			  app.post '/edit/:id' do
				protected!
				post ||= Post.get(params[:id]) || halt(404)
				if post.update(:title => params[:title], :slug => params[:title].slugify, :body => params[:body])
				  redirect '/'
				else
				  new_post.errors.each do |e|
				   puts e
				  end
				  halt 500
				end
			  end

			  app.get '/edit/:id' do
				protected!
				post ||= Post.get(params[:id]) || halt(404)
				@post = Post.first
				erb :create 
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