module Sinatra::SimpleRubyBlog::Routing::PermissionAdmin
  def self.registered(app)
    slug =  'perms'

    get_create = lambda do 
      render_output('admin/profile/permissions/control', 'layouts/control')
    end

    post_create = lambda do 
      do_create(Permission, slug,
              :title => params[:title],
              :description => params[:description],
              :roles => Role.all(:id => add_missing(params[:roles], Role)))
    end

    get_edit = lambda do 
      do_output(Permission.first(:id => params[:id]), 'admin/profile/permissions/control', 'layouts/control')
    end

    post_edit = lambda do 
      do_edit(Permission.first(:id => params[:id]), slug, 
                :title => params[:title],
                :description => params[:description],
                :roles => Role.all(:id => add_missing(params[:roles], Role)))
    end

    get_delete = lambda do 
      do_delete(Permission, '/perms')
    end

    get_index = lambda do 
      do_output(Permission.paginate(:page => params[:page]), 'admin/profile/permissions/list')
    end

    app.namespace '/perms' do
      before  { 
        auth? 
        @page_title = t.permissions.titles.default
        @page_description = t.permissions.description
        @page_slug = slug
      }

      get  '/create', &get_create
      post '/create', &post_create

      get  '/edit/:id', &get_edit
      post '/edit/:id', &post_edit

      get  '/delete/:id', &get_delete

      get  &get_index
    end
  end
end