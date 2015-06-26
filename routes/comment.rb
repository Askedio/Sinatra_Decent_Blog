 module Sinatra
  module SimpleRubyBlog
    module Routing
      module CommentControl
		def self.registered(app)

			  app.post '/comment/:id' do
				halt 404 unless params[:website].empty?
				post ||= Post.get(params[:id]) || halt(404)

				comments = params[:body].gsub(/<\/?[^>]*>/, "")
				name = params[:name].gsub(/<\/?[^>]*>/, "")
				email = params[:email].gsub(/<\/?[^>]*>/, "")

				post.comments.new(:body => comments, :name => name, :email => email)
				if !post.save
					do_error post.errors
				end

				session[:comment_name] = name
				session[:comment_email] = email

				Helpers::Mail.send_all(email, 'Comments made', "Post: /#{post.slug}<br>Name: #{name}<br>Email: #{email}<br>Comment: #{comments}", './views/emails/email.erb')
					
				redirect "/#{post.slug}"
			  end

			app.get '/comment/delete/:id' do
				protected!
				post ||= Comment.first(:id => params[:id]) || halt(404)
				halt 500 unless post.destroy
				redirect "/#{post.post.slug}"
			end

		  end
	   end
    end
  end
end