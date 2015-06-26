 module Sinatra
  module SimpleRubyBlog
    module Routing
      module Profile
		def self.registered(app)

			  app.get '/profile/create' do 
				protected!
				erb :"admin/profile/control" 
			  end

			  app.post '/profile/create' do
				protected!
				person = Person.new(:name => params[:name], :title => params[:title], :email => params[:email], :avatar => params[:avatar], :about => params[:about], :password => params[:password])
				if person.save
				  new_person ||= Person.first(:name => params[:name]) || halt(500)
				  flash[:success] = true
				  redirect "/profile/#{new_person.name}"
				else
					do_error person.errors
					redirect "/profile/create"
				end
			  end

			  app.get '/profile/:id' do 
				protected!
				@persons = Person.all
				@person ||= Person.first(:name => params[:id]) || halt(404)
				erb :"admin/profile/control" 
			  end

			  app.post '/profile/:id' do
				protected!
				person ||= Person.first(:name => params[:id]) || halt(404)
				if person.update(:name => params[:name],:slug => params[:slug], :title => params[:title], :email => params[:email], :avatar => params[:avatar], :about => params[:about], :password => params[:password])
					flash[:success] = true
				else
					do_error person.errors
				end
			    redirect "/profile/#{params[:id]}"
			  end

			  app.get '/profile/delete/:id' do
				protected!
				person ||= Person.first(:name => params[:id]) || halt(404)
				halt 500 unless person.destroy
				redirect '/authors'
			  end
			  
			  app.get '/profile' do 
				protected!
				@persons = Person.all
				@person ||= Person.first(:name => session[:username]) || halt(404)
				erb :"admin/profile/control" 
			  end

			  app.post '/profile' do
				protected!
				person ||= Person.first(:name => session[:username]) || halt(404)
				person.update(:name => params[:name],:slug => params[:slug], :avatar => params[:avatar], :about => params[:about], :password => params[:password])
				flash[:success] = true
			    redirect '/profile'
			  end


		  end
	   end
    end
  end
end