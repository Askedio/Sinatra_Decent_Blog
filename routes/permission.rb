module Sinatra::SimpleRubyBlog::Routing::PermissionAdmin
  module Helpers
   def conf
    @page_title = t.permissions.titles.default
    @page_description = t.permissions.description
    @page_slug = 'perms'
    nil
   end

   def default_data
    {
      :title => params[:title],
      :description => params[:description],
      :roles => Role.all(:id => add_missing(params[:roles], Role))
    }
   end

   def default_item
     {
       :id => params[:id]
     }
   end

   def default_index
     {
       :page => params[:page]
     }
   end
  end

  def self.registered(app)
    app.helpers Helpers

    model = Permission
    slug =  'perms'
    control = 'admin/profile/permissions/control'
    list = 'admin/profile/permissions/list'
    layout = 'layouts/control'


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
        conf
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