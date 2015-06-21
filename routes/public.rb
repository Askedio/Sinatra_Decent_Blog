 module Sinatra
  module SimpleRubyBlog
    module Routing
      module Public
		def self.registered(app)

			  app.get '/posts/:id' do
				post ||= Post.get(params[:id]) || halt(404)
				@post = Post.first
				erb :details 
			  end

			  app.get '/' do
				@posts = Post.paginate( :page => params[:page], :order => [:created_at.desc ])
				erb :index 
			  end

		  end
	   end
    end
  end
end