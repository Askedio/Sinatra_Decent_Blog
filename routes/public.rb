 module Sinatra
  module SimpleRubyBlog
    module Routing
      module Public
		def self.registered(app)

			  app.get '/posts/:id' do
				post ||= Post.get(params[:id]) || halt(404)
				@post = post
				@page_title = post.title
				@page_image = post.image
				description = post.body.gsub(/<\/?[^>]*>/, "")
				@page_description = description[0..255]
				erb :"public/details" 
			  end

			  app.get '/' do	
				@posts = Post.paginate(:draft => nil, :page => params[:page], :order => [:created_at.desc ])
				@page_description = 'A day-to-day log of the questions we\'ve asked &amp; the answers we\'ve found.'
				erb :"public/index" 
			  end

			  app.get '/page/:page' do	
				@posts = Post.paginate(:draft => nil, :page => params[:page], :order => [:created_at.desc ])
				@page_description = 'A day-to-day log of the questions we\'ve asked &amp; the answers we\'ve found.'
				erb :"public/index" 
			  end


			  app.get '/drafts' do	
				@posts = Post.paginate(:draft => 1, :page => params[:page], :order => [:created_at.desc ])
				@page_description = 'A day-to-day log of the questions we\'ve asked &amp; the answers we\'ve found.'
				erb :"public/index" 
			  end

			  app.get '/search/:query' do 
				@posts = Post.paginate(:draft => nil, :page => params[:page], :order => [:created_at.desc ],:body.like => "%#{params[:query]}%") 
				@page_description = 'A day-to-day log of the questions we\'ve asked &amp; the answers we\'ve found.'
				erb :"public/index" 
			  end

			  app.get '/authors' do 
				@posts = Person.paginate(:page => params[:page]) 
				@page_description = 'Who writes for Asked.io? We do :D'
				erb :"public/authors" 
			  end

			  app.get '/author/:id' do 
				@posts = Person.paginate(:page => params[:page], :name => params[:id]) 
				@page_description = 'Who writes for Asked.io? We do :D'
				erb :"public/authors" 
			  end

			  app.get '/rss' do
				@posts = Post.all
			    builder :rss
			  end
		  end
	   end
    end
  end
end