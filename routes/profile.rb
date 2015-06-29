module Sinatra::SimpleRubyBlog::Routing::Profile
  def self.registered(app)
    get_create = lambda do 
      can('authors')
      render_output('admin/profile/control','layouts/control')
    end

    post_create = lambda do 
      can('authors')
      person = Person.new(:name => params[:name],
                  :slug => params[:name].slugify,
                  :roles => Role.all(:id => params[:roles]),
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



    get_delete = lambda do 
      can('authors')
      person ||= Person.first(:name => params[:id]) || halt(404)
      halt 500 unless person.destroy
      redirect '/authors'
    end

    # Next 2 functions are for the actual user so no permission checks, just in post when we want to assign a role.
    get_profile = lambda do 
      @persons = Person.all
      @person ||= Person.first(:name => params[:id]) || halt(404)
      render_output('admin/profile/control','layouts/control')
    end

    post_profile = lambda do 
      person ||= Person.first(:name => params[:id]) || halt(404)
      if person.update(:name => params[:name],
                  :slug => params[:slug].slugify,
                  :roles => (can_do('roles') ? Role.all(:id => params[:roles]) : person.roles.all),
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