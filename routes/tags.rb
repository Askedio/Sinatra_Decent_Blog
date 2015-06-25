 module Sinatra
  module SimpleRubyBlog
    module Routing
      module TagAdmin
		def self.registered(app)

			  app.get '/tag/create' do 
				protected!
				@page_title = 'Tags'
				@page_slug = 'tag'
				erb :"admin/manage/control" 
			  end

			  app.post '/tag/create' do
				protected!
				person = Tag.new(:title => params[:title], :description => params[:description])
				if person.save
				  new_person ||= Tag.first(:title => params[:title]) || halt(500)
				  flash[:success] = true
				  redirect "/tag/edit/#{new_person.id}"
				else
					do_error person.errors
					redirect "/tag/create"
				end
			  end

			  app.get '/tag/edit/:id' do 
				protected!
				@person ||= Tag.first(:id => params[:id]) || halt(404)
				@page_title = 'Tags'
				@page_slug = 'tag'
				erb :"admin/manage/control" 
			  end

			  app.post '/tag/edit/:id' do
				protected!
				person ||= Tag.first(:id => params[:id]) || halt(404)
				if person.update(:title => params[:title], :slug => params[:slug], :description => params[:description])
					flash[:success] = true
				else
					do_error person.errors
				end
				redirect "/tag/edit/#{params[:id]}"
			  end

			  app.get '/tag/delete/:id' do
				protected!
				person ||= Tag.first(:id => params[:id]) || halt(404)
				halt 500 unless person.destroy
				redirect '/tags'
			  end
			  
			  app.get '/tags' do 
				@posts = Tag.paginate(:page => params[:page]) 
				@page_description = 'We have categories! Browse our grouped posts, pretty legit!'
				@page_title = 'Tags'
				@page_slug = 'tag'
				erb :"public/list" 
			  end

			  app.get '/tag/:title' do 
				cat ||= Tag.first(:slug => params[:title])|| halt(404)
				@posts =  cat.posts.paginate(:page => params[:page]) 
				@page_description = 'We have tags! Browse our tagged posts, pretty legit!'
				erb :"public/index" 
			  end

		  end
	   end
    end
  end
end