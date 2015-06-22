 module Sinatra
  module SimpleRubyBlog
    module Routing
      module Profile
		def self.registered(app)

			  app.get '/profile' do 
				protected!
				@persons = Person.all
				@person ||= Person.first(:name => session[:username]) || halt(404)
				erb :"admin/profile/edit" 
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