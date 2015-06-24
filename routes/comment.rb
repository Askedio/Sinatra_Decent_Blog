 module Sinatra
  module SimpleRubyBlog
    module Routing
      module CommentControl
		def self.registered(app)

			  app.post '/comment/:id' do
				halt 404 unless params[:website].empty?
				post ||= Post.get(params[:id]) || halt(404)
				post.comments.new(:body => params[:body], :name => params[:name], :email => params[:email])
				  if !post.save
					do_error post.errors
				  end
				redirect "/posts/#{post.slug}"
			  end

			app.get '/comment/delete/:id' do
				protected!
				post ||= Comment.first(:id => params[:id]) || halt(404)
				halt 500 unless post.destroy
				redirect "/posts/#{post.post.slug}"
			end

		  end
	   end
    end
  end
end