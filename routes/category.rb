 module Sinatra
  module SimpleRubyBlog
    module Routing
      module CategoryAdmin
		def self.registered(app)

			  app.get '/category/create' do 
				protected!
				@page_title = 'Categories'
				@page_slug = 'category'
				erb :"admin/manage/control" 
			  end

			  app.post '/category/create' do
				protected!
				person = Category.new(:title => params[:title], :description => params[:description])
				if person.save
				  redirect '/categories'
				else
					do_error person.errors
					redirect "/category/create"
				end
			  end

			  app.get '/category/edit/:id' do 
				protected!
				@person ||= Category.first(:id => params[:id]) || halt(404)
				@page_title = 'Categories'
				@page_slug = 'category'
				erb :"admin/manage/control" 
			  end

			  app.post '/category/edit/:id' do
				protected!
				person ||= Category.first(:id => params[:id]) || halt(404)
				person.update(:title => params[:title],:slug => params[:slug], :description => params[:description])
			    redirect '/categories'
			  end

			  app.get '/category/delete/:id' do
				protected!
				person ||= Category.first(:id => params[:id]) || halt(404)
				halt 500 unless person.destroy
				redirect '/categories'
			  end
			  
			  app.get '/category/:title' do 
				cat ||= Category.first(:slug => params[:title])|| halt(404)
				@posts =  cat.posts.paginate(:page => params[:page]) 
				@page_description = 'We have categories! Browse our grouped posts, pretty legit!'
				erb :"public/index" 
			  end

			  app.get '/categories' do 
				@posts = Category.paginate(:page => params[:page]) 
				@page_description = 'We have categories! Browse our grouped posts, pretty legit!'
				@page_title = 'Categories'
				@page_slug = 'category'
				erb :"public/list" 
			  end

		  end
	   end
    end
  end
end