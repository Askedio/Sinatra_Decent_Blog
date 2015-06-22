 module Sinatra
  module SimpleRubyBlog
    module Routing
      module Profile
		def self.registered(app)

			  app.get '/profile/create' do 
				protected!
				@persons = Person.all
				erb :"admin/profile/create" 
			  end

			  app.post '/profile/create' do
				protected!


				person = Person.new(:name => params[:name], :avatar => params[:avatar], :about => params[:about], :password => params[:password])

				if person.save
				  redirect '/'
				else
				  person.errors.each do |e|
				   puts e
				  end
				  halt 500
				end
			  end

			  app.get '/profile/:id' do 
				protected!
				@persons = Person.all
				@person ||= Person.first(:name => params[:id]) || halt(404)
				erb :"admin/profile/create" 
			  end

			  app.post '/profile/:id' do
				protected!
				person ||= Person.first(:name => params[:id]) || halt(404)
				person.update(:name => params[:name], :avatar => params[:avatar], :about => params[:about], :password => params[:password])
			    redirect '/profile'
			  end

			  app.get '/profile/delete/:id' do
				protected!
				person ||= Person.first(:name => params[:id]) || halt(404)
				halt 500 unless person.destroy
				redirect '/'
			  end
			  
			  app.get '/profile' do 
				protected!
				@persons = Person.all
				@person ||= Person.first(:name => session[:username]) || halt(404)
				erb :"admin/profile/create" 
			  end

			  app.post '/profile' do
				protected!
				person ||= Person.first(:name => session[:username]) || halt(404)
				person.update(:name => params[:name], :avatar => params[:avatar], :about => params[:about], :password => params[:password])
			    redirect '/profile'
			  end


		  end
	   end
    end
  end
end