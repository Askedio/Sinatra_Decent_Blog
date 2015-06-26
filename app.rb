require_relative  'init'


class SimpleRubyBlog < Sinatra::Base
  
  enable :sessions

  set :root, File.dirname(__FILE__)

  helpers Sinatra::SimpleRubyBlog::Helpers
  
  register Sinatra::Flash

  register WillPaginate::Sinatra

  register Sinatra::SimpleRubyBlog::Routing::BlogAdmin
 
  register Sinatra::SimpleRubyBlog::Routing::TagAdmin

  register Sinatra::SimpleRubyBlog::Routing::CategoryAdmin

  register Sinatra::SimpleRubyBlog::Routing::PermissionAdmin

  register Sinatra::SimpleRubyBlog::Routing::Profile

  register Sinatra::SimpleRubyBlog::Routing::CommentControl

  register Sinatra::SimpleRubyBlog::Routing::Public

  use Rack::Static, :urls => ['/css', '/js', '/images'], :root => 'public/assests'

  WillPaginate.per_page = 8

end