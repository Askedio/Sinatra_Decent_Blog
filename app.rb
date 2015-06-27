class SimpleRubyBlog < Sinatra::Base
  
  enable :sessions
  



  configure :development do
    register Sinatra::Reloader
  end

  register Sinatra::ConfigFile
  config_file 'config/config.yml'

  set :root, File.dirname(__FILE__)

  helpers Sinatra::SimpleRubyBlog::Helpers
  
  register Sinatra::Flash

  register Sinatra::Namespace

  register Sinatra::R18n
  R18n::I18n.default = 'en'

  register WillPaginate::Sinatra

  register Sinatra::SimpleRubyBlog::Routing::BlogAdmin
 
  register Sinatra::SimpleRubyBlog::Routing::TagAdmin

  register Sinatra::SimpleRubyBlog::Routing::CategoryAdmin

  register Sinatra::SimpleRubyBlog::Routing::PermissionAdmin

  register Sinatra::SimpleRubyBlog::Routing::Profile

  register Sinatra::SimpleRubyBlog::Routing::CommentControl

  register Sinatra::SimpleRubyBlog::Routing::Public

  #register Sinatra::RouteGroup
 
  use Rack::Static, :urls => ['/css', '/js', '/images'], :root => 'public/assests'

  use Rack::Session::Moneta, store: Moneta.new(:DataMapper, setup: "sqlite3://#{$data_dir}/my_app.db")
 
  WillPaginate.per_page = 8

  not_found{ render_output('not_found') }

end