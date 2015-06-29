class SimpleRubyBlog < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  register Sinatra::ConfigFile
  config_file 'config/config.yml'

  set :root, File.dirname(__FILE__)

  helpers Sinatra::SimpleRubyBlog::Helpers
  helpers Sinatra::SimpleRubyBlog::Helpers::Routes
  helpers Sinatra::SimpleRubyBlog::Helpers::Auth
  
  register Sinatra::Flash

  register Sinatra::Namespace

  register Sinatra::R18n

  register WillPaginate::Sinatra

  register Sinatra::SimpleRubyBlog::Routing
 
  register Sinatra::SimpleRubyBlog::Routing::BlogAdmin
 
  register Sinatra::SimpleRubyBlog::Routing::TagAdmin

  register Sinatra::SimpleRubyBlog::Routing::CategoryAdmin

  register Sinatra::SimpleRubyBlog::Routing::RoleAdmin

  register Sinatra::SimpleRubyBlog::Routing::PermissionAdmin

  register Sinatra::SimpleRubyBlog::Routing::Profile

  register Sinatra::SimpleRubyBlog::Routing::CommentControl

  register Sinatra::SimpleRubyBlog::Routing::Public
 
  use Rack::Static, :urls => ['/css', '/js', '/images'], :root => 'public/assests'
  use Rack::Session::Moneta, store: Moneta.new(:DataMapper, setup: "sqlite3://#{$data_dir}/my_app.db")
 
  WillPaginate.per_page = settings.post_per_page

  R18n::I18n.default = settings.language

  not_found{ render_output('not_found') }

end