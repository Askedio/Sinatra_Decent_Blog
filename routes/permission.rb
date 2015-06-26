 module Sinatra
  module SimpleRubyBlog
   module Routing
    module PermissionAdmin
     def self.registered(app)
        app.get '/perms/create' do
          protected!
          @page_title = 'Permissions'
          @page_slug = 'perms'
          erb :"admin/profile/permissions/control", :layout => :'layouts/control'
        end

        app.post '/perms/create' do
          protected!
          roles ||= Role.all(:id => add_missing(params[:roles], Roles)) || halt(500)
          person = Permission.new(:title => params[:title], :description => params[:description], :roles => roles)
          if person.save
            new_person ||= Permission.first(:title => params[:title]) || halt(500)
            flash[:success] = true
            redirect "/perms/edit/#{new_person.id}"
          else
            do_error person.errors
            redirect "/perms/create"
          end
        end

        app.get '/perms/edit/:id' do
          protected!
          @person ||= Permission.first(:id => params[:id]) || halt(404)
          @page_title = 'Permissions'
          @page_slug = 'perms'
          erb :"admin/profile/permissions/control", :layout => :'layouts/control'
          end

          app.post '/perms/edit/:id' do
          protected!
          person ||= Permission.first(:id => params[:id]) || halt(404)
          roles ||= Role.all(:id => add_missing(params[:roles], Role)) || halt(404)
          if person.update(:title => params[:title], :roles => roles, :description => params[:description])
            flash[:success] = true
          else
            do_error person.errors
          end
          redirect "/perms/edit/#{params[:id]}"
          end

          app.get '/perms/delete/:id' do
          protected!
          person ||= Permission.first(:id => params[:id]) || halt(404)
          halt 500 unless person.destroy
          redirect '/perms'
        end

        app.get '/perms' do
          protected!
          @posts = Permission.paginate(:page => params[:page])
          @page_description = 'We have permissions! Browse our permissions, pretty legit!'
          @page_title = 'Permissions'
          @page_slug = 'perms'
          erb :"admin/profile/permissions/list"
        end

      end
     end
    end
  end
end