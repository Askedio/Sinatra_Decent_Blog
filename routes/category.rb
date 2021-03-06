module Sinatra::SimpleRubyBlog::Routing::CategoryAdmin
  def self.registered(app)

    get_create = lambda do 
      render_output('admin/manage/control', 'layouts/control')
    end

    post_create = lambda do 
      person = Category.new(:title => params[:title], :description => params[:description])
      if person.save
        flash[:success] = true
        redirect "/admin/category/edit/#{person.id}"
      else
        do_error person.errors
        redirect "/admin/category/create"
      end
    end

    get_edit = lambda do 
      @person ||= Category.first(:id => params[:id]) || halt(404)
      render_output('admin/manage/control', 'layouts/control')
    end

    post_edit = lambda do 
      person ||= Category.first(:id => params[:id]) || halt(404)
      if person.update(:title => params[:title], :slug => params[:slug], :description => params[:description])
        flash[:success] = true
      else
        do_error person.errors
      end
      redirect "/admin/category/edit/#{params[:id]}"
    end

    get_delete = lambda do 
      person ||= Category.first(:id => params[:id]) || halt(404)
      halt 500 unless person.destroy
      redirect '/categories'
    end

    get_category = lambda do 
      cat ||= Category.first(:slug => params[:title])|| halt(404)
      @posts =  cat.posts.paginate(:page => params[:page], :order => [ :updated_at.desc ])
      @page_slug = 'category'
      render_output('public/index', nil, cat.title, (defined?cat.description ? cat.description.striptags[0..255] : t.category.description))
    end

    get_index = lambda do 
      @posts = Category.paginate(:page => params[:page])
      @page_slug = 'category'
      render_output('public/list', nil, t.category.titles.default, t.category.description)
    end

    app.namespace '/admin/category' do
      before  { 
        auth? 
        @page_title = t.category.titles.default
        @page_description = t.category.description
        @page_slug = 'category'
      }

      get  '/create', &get_create
      post '/create', &post_create

      get  '/edit/:id', &get_edit
      post '/edit/:id', &post_edit

      get  '/delete/:id', &get_delete
    end

    app.get '/category/:title', &get_category
    app.get '/categories', &get_index

  end
end
