 module Sinatra
  module SimpleRubyBlog
    module Routing
      module Public
		def self.registered(app)

			  app.get '/posts/:id' do
				post ||= Post.get(params[:id]) || halt(404)
			    @persons = Person.all
				@post = post
				@page_title = post.title
				@page_image = post.image
				description = post.body.gsub(/<\/?[^>]*>/, "")
				@page_description = description[0..255]
				erb :"public/details" 
			  end

			  app.get '/' do	
			    @persons = Person.all
				@posts = Post.paginate( :page => params[:page], :order => [:created_at.desc ])
				@page_description = 'Day to Day Question &amp; Answers a Full-Stack web-developer has.'
				erb :"public/index" 
			  end

		  end
	   end
    end
  end
end