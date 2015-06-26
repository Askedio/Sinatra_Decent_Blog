 module Sinatra
  module SimpleRubyBlog
    module Routing
     module Public
      def self.registered(app)

        get_index = lambda do 
          @posts = Post.paginate(:draft => nil, :page => params[:page], :order => [:created_at.desc ])
          @page_description = t.public.titles.default

          @featured = Post.first(:offset => rand(Post.all(:featured.not => nil).count), :draft => nil, :featured.not => nil)
          render_output('public/index','layouts/home')
        end

        get_drafts = lambda do 
          @posts = Post.paginate(:draft => 1, :page => params[:page], :order => [:created_at.desc ])
          @page_description = t.public.titles.default
          render_output('public/index')
        end

        get_search = lambda do 
          @posts = Post.paginate(:draft => nil, :page => params[:page], :order => [:created_at.desc ], :body.like => "%#{params[:query]}%")
          @page_description = t.public.titles.default
          render_output('public/index')
        end

        get_authors = lambda do 
          @posts = Person.paginate(:page => params[:page])
          @page_description = t.public.titles.authors
          render_output('public/authors')
        end

        get_author = lambda do 
          @posts = Person.paginate(:page => params[:page], :slug => params[:id])
          @page_description = t.public.titles.authors
          render_output('public/authors')
        end

        get_author_posts = lambda do 
          person ||= Person.first(:slug => params[:id]) || halt(404)
          @posts = person.posts.paginate(:draft => nil, :page => params[:page], :order => [:created_at.desc ])
          @page_description = t.public.titles.default
          render_output('public/index')
        end

        get_featured = lambda do 
          @posts = Post.paginate(:draft => nil, :page => params[:page], :order => [:created_at.desc ], :featured.not => nil)
          @page_description = t.public.titles.featured
          render_output('public/index')
        end
        get_rss = lambda do 
          @posts = Post.all
          builder :'rss/index'
        end

        get_post = lambda do 
          post ||= Post.get(params[:id]) || halt(404)
          unless !request.env["HTTP_USER_AGENT"].match(/\(.*https?:\/\/.*\)/).nil?
            stat ||= Stat.first_or_create(:post_slug => params[:id]) || halt(404)
            stat.update(:hits => (defined?(post.stat.hits) && (post.stat.hits.is_a? Integer)) ? (post.stat.hits+1) : 1)
          end

          @posts =  [post]
          @page_title = post.title
          @page_image = post.image
          @page_description = post.body.gsub(/<\/?[^>]*>/, "")[0..255]
          render_output('public/index', (post.template ? (:"#{post.template}") : (:'layout')))
        end

        app.get '/', &get_index
        app.get '/drafts', &get_drafts
        app.get '/search/:query', &get_search
        app.get '/authors', &get_authors
        app.get '/author/:id', &get_author
        app.get '/author/:id/posts', &get_author_posts
        app.get '/featured', &get_featured
        app.get '/rss', &get_rss
        app.get '/:id', &get_post

      end
     end
    end
  end
end