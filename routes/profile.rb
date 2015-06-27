module Sinatra::SimpleRubyBlog::Routing::Profile
  def self.registered(app)
    get_create = lambda do 
      render_output('admin/profile/control','layouts/control')
    end

    post_create = lambda do 
      perms ||= Permission.all(:id => params[:permissions]) || halt(404)
      person = Person.new(:name => params[:name],
                  :slug => params[:name].slugify,
                  :permissions => perms,
                  :title => params[:title],
                  :email => params[:email],
                  :avatar => params[:avatar],
                  :about => params[:about],
                  :password => params[:password])
      if person.save
        flash[:success] = true
        redirect "/profile/#{person.name}"
      else
        do_error person.errors
        redirect "/profile/create"
      end
    end

    get_profile = lambda do 
      @persons = Person.all
      @person ||= Person.first(:name => params[:id]) || halt(404)
      render_output('admin/profile/control','layouts/control')
    end

    post_profile = lambda do 
      person ||= Person.first(:name => params[:id]) || halt(404)
      perms ||= Permission.all(:id => params[:permissions]) || halt(404)
      if person.update(:name => params[:name],
                  :permissions => perms,
                  :slug => params[:slug].slugify,
                  :title => params[:title],
                  :email => params[:email],
                  :avatar => params[:avatar],
                  :about => params[:about],
                  :password => params[:password])
        flash[:success] = true
      else
        do_error person.errors
      end
        redirect "/profile/#{params[:id]}"
    end

    get_delete = lambda do 
      person ||= Person.first(:name => params[:id]) || halt(404)
      halt 500 unless person.destroy
      redirect '/authors'
    end

    app.namespace '/profile' do
      before  { 
        auth? 
        @page_title = t.profile.titles.default
        @page_description = t.profile.description
      }

      get  '/create', &get_create
      post '/create', &post_create
        
      get  '/:id', &get_profile
      post '/:id', &post_profile

      get  '/delete/:id', &get_delete
    end

end
end