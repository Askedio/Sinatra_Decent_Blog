module Sinatra::SimpleRubyBlog::Routing::CommentControl
  def self.registered(app)
    post_comment = lambda do 
      halt 404 unless params[:website].empty?
      post ||= Post.get(params[:id]) || halt(404)

      comments = params[:body].striptags
      name = params[:name].striptags
      email = params[:email].striptags

      post.comments.new(:body => comments, :name => name, :email => email)
      if !post.save
        do_error post.errors
      end

      session[:comment_name] = name
      session[:comment_email] = email

      Helpers::Mail.send_all(email, 'Comments made', "Post: /#{post.slug}<br>Name: #{name}<br>Email: #{email}<br>Comment: #{comments}", './views/emails/email.erb')

      redirect "/#{post.slug}"
    end

    get_delete = lambda do 
      auth?
      post ||= Comment.first(:id => params[:id]) || halt(404)
      halt 500 unless post.destroy
      redirect "/#{post.post.slug}"
    end

    app.namespace '/comment' do
      post  '/:id', &post_comment

      get   '/delete/:id', &get_delete
    end

  end
end