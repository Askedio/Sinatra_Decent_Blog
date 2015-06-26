 module Sinatra
  module SimpleRubyBlog
    module Routing
      module TagAdmin
        def self.registered(app)

          get_create = lambda do 
            render_output('admin/manage/control', 'layouts/control')
          end

          post_create = lambda do 
            person = Tag.new(:title => params[:title], :description => params[:description])
            if person.save
              new_person ||= Tag.first(:title => params[:title]) || halt(500)
              flash[:success] = true
              redirect "/tag/edit/#{new_person.id}"
            else
              do_error person.errors
              redirect "/tag/create"
            end
          end

          get_edit = lambda do 
            @person ||= Tag.first(:id => params[:id]) || halt(404)
            render_output('admin/manage/control', 'layouts/control')
          end

          post_edit = lambda do 
            person ||= Tag.first(:id => params[:id]) || halt(404)
            if person.update(:title => params[:title], :slug => params[:slug], :description => params[:description])
              flash[:success] = true
            else
              do_error person.errors
            end
            redirect "/tag/edit/#{params[:id]}"
          end

          get_delete = lambda do 
            person ||= Tag.first(:id => params[:id]) || halt(404)
            halt 500 unless person.destroy
            redirect '/tags'
          end

          get_tag = lambda do 
            cat ||= Tag.first(:slug => params[:title])|| halt(404)
            @posts =  cat.posts.paginate(:page => params[:page], :order => [ :updated_at.desc ])
            @page_title = cat.title
            @page_description = cat.description
            render_output('public/index')
         end

          get_index = lambda do 
            @posts = Tag.paginate(:page => params[:page])
            @page_title = t.tag.titles.default
            @page_description = t.tag.description
            @page_slug = 'tag'
            render_output('public/list')
          end

          app.namespace '/tag' do
            before  { 
              auth? 
              @page_title = t.tag.titles.default
              @page_description = t.tag.description
            }

            get '/create', &get_create
            post '/create', &post_create

            get '/edit/:id', &get_edit
            post '/edit/:id', &post_edit

            get '/delete/:id', &get_delete
          end

          app.get '/tags', &get_index
          app.get '/tag/:title', &get_tag

        end
      end
    end
  end
end