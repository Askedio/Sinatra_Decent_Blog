module Sinatra::SimpleRubyBlog::Routing::RoleAdmin
  module Helpers
    def role_conf
      # MODULE SETTINGS
      @page_title = t.roles.titles.default
      @page_description = t.roles.description
      nil
    end
    def roles_data
      {
        :title => params[:title],
        :description => params[:description],
        :permissions => Permission.all(:id => add_missing(params[:permissions], Permission))
      }
    end
  end

  def self.registered(app)
    app.helpers Helpers

    # MODULE SETTINGS
    model   = Role
    slug    = 'admin/roles'
    control = 'admin/profile/permissions/control'
    list    = 'admin/manage/list'
    layout  = 'layouts/control'

    get_index = lambda do 
      do_output(model.paginate(default_index), list)
    end

    get_create = lambda do 
      render_output(control, layout)
    end

    get_edit = lambda do 
      do_output(model.first(default_item), control, layout)
    end

    get_delete = lambda do 
      do_delete(model, "/#{slug}")
    end

    post_create = lambda do 
      do_create(model, slug, roles_data)
    end

    post_edit = lambda do 
      do_edit(model.first(default_item), slug, roles_data)
    end

    app.namespace "/#{slug}"  do
      before  { 
        auth? 
        role_conf
        @page_slug = slug
      }

      get  &get_index
      get  '/create', &get_create
      get  '/edit/:id', &get_edit
      get  '/delete/:id', &get_delete
      post '/create', &post_create
      post '/edit/:id', &post_edit
    end
  end
end