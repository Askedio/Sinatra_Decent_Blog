module Sinatra
  module SimpleRubyBlog
    module Routing
      module PermissionAdmin
        def self.registered(app)

          get_create = lambda do 
            render_output('admin/profile/permissions/control', 'layouts/control')
          end

          post_create = lambda do 
           roles ||= Role.all(:id => add_missing(params[:roles], Roles)) || halt(500)
            person = Permission.new(:title => params[:title], :description => params[:description], :roles => roles)
            if person.save
              flash[:success] = true
              redirect "/perms/edit/#{person.id}"
            else
              do_error person.errors
              redirect "/perms/create"
            end 
          end

          get_edit = lambda do 
            @person ||= Permission.first(:id => params[:id]) || halt(404)
            render_output('admin/profile/permissions/control', 'layouts/control')
          end

          post_edit = lambda do 
            person ||= Permission.first(:id => params[:id]) || halt(404)
            roles ||= Role.all(:id => add_missing(params[:roles], Role)) || halt(404)
            if person.update(:title => params[:title], :roles => roles, :description => params[:description])
              flash[:success] = true
            else
              do_error person.errors
            end
            redirect "/perms/edit/#{params[:id]}"
          end

          get_delete = lambda do 
            person ||= Permission.first(:id => params[:id]) || halt(404)
            halt 500 unless person.destroy
            redirect '/perms'
          end

          get_index = lambda do 
            @page_title = t.permissions.titles.default
            @page_description = t.permissions.description
            @page_slug = 'perms'
            @posts = Permission.paginate(:page => params[:page])
            render_output('admin/profile/permissions/list')
          end

          app.namespace '/perms' do
            before  { 
              auth? 
              @page_title = t.permissions.titles.default
              @page_description = t.permissions.description
              @page_slug = 'perms'
            }

            get '/create', &get_create
            post '/create', &post_create

            get '/edit/:id', &get_edit
            post '/edit/:id', &post_edit

            get '/delete/:id', &get_delete
          end
          
          app.get '/perms', &get_index

        end
      end
    end
  end
end