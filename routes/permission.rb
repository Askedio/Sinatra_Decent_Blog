module Sinatra::SimpleRubyBlog::Routing::PermissionAdmin
  module Helpers
    def perms_conf
      # MODULE SETTINGS
      @page_title = t.permissions.titles.default
      @page_description = t.permissions.description
      nil
    end
    def perms_auth
      can('permissions')
    end
  end

  def self.registered(app)
    app.helpers Helpers

    # MODULE SETTINGS
    model   = Permission
    slug    = 'admin/permissions'
    control = 'admin/manage/control'
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
      do_create(model, slug, default_data)
    end

    post_edit = lambda do 
      do_edit(model.first(default_item), slug, default_data)
    end

    app.namespace "/#{slug}"  do
      before  { 
        auth? 
        perms_conf
        perms_auth
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