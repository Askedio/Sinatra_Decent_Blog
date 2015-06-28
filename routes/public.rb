module Sinatra::SimpleRubyBlog::Routing::Public
  def self.registered(app)

    get_index = lambda do 
      @posts = Post.paginate(:draft => nil, :page => params[:page], :order => [:created_at.desc ])
      @featured = Post.first(:offset => rand(Post.all(:featured.not => nil).count), :draft => nil, :featured.not => nil)
      render_output('public/index','layouts/home', t.public.titles.default, t.public.description)
    end

    get_drafts = lambda do 
      @posts = Post.paginate(:draft => 1, :page => params[:page], :order => [:created_at.desc ])
      render_output('public/index', nil, t.drafts.titles.default, t.drafts.description)
    end

    get_search = lambda do 
      @posts = Post.paginate(:draft => nil, :page => params[:page], :order => [:created_at.desc ], :body.like => "%#{params[:query].striptags}%")
      render_output('public/index', nil, t.search.titles.default, t.search.description)
    end

    get_authors = lambda do 
      @posts = Person.paginate(:page => params[:page])
      render_output('public/authors', nil, t.authors.titles.authors, t.authors.description)
    end

    get_author = lambda do 
      @posts = Person.paginate(:page => params[:page], :slug => params[:id])
      render_output('public/authors', nil, @posts.name, t.authors.description)
    end

    get_author_posts = lambda do 
      person ||= Person.first(:slug => params[:id]) || halt(404)
      @posts = person.posts.paginate(:draft => nil, :page => params[:page], :order => [:created_at.desc ])
      render_output('public/index', nil, t.authors.titles.authors, t.authors.description)
    end

    get_featured = lambda do 
      @posts = Post.paginate(:draft => nil, :page => params[:page], :order => [:created_at.desc ], :featured.not => nil)
      render_output('public/index', nil, t.featured.titles.default, t.featured.description)
    end
    get_rss = lambda do 
      @posts = Post.all(:order => [:created_at.desc ])
      builder :'rss/index'
    end

    get_post = lambda do 
      post ||= Post.get(params[:id]) || halt(404)
      unless !request.env["HTTP_USER_AGENT"].match(/\(.*https?:\/\/.*\)/).nil?
        stat ||= Stat.first_or_create(:post_slug => params[:id]) || halt(404)
        stat.update(:hits => (defined?(post.stat.hits) && (post.stat.hits.is_a? Integer)) ? (post.stat.hits+1) : 1)
      end
      # Wrap post into array on @posts so we can re-use the same template
      @posts =  [post]
      render_output('public/index', (post.template ? (:"#{post.template}") : (:'layout')), post.title, post.body.striptags[0..255])
    end

    get_logout = lambda do 
      unauthorize
      redirect '/'
    end

    get_login = lambda do 
      render_output('public/login')
    end

    post_login = lambda do 
     redirect login(params[:user], params[:password]) ? (!params[:redirect_to].strip!.empty? ? params[:redirect_to] : '/') : '/login'
    end

    app.get '/', &get_index
    app.get '/drafts', &get_drafts
    app.get '/search/:query', &get_search
    app.get '/authors', &get_authors
    app.get '/featured', &get_featured
    app.get '/rss', &get_rss

    app.get  '/logout', &get_logout
    app.get  '/login', &get_login
    app.post '/login', &post_login

    app.get '/:id', &get_post

    app.namespace '/author' do
      get '/:id', &get_author
      get '/:id/posts', &get_author_posts
    end
  end
end