require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-sqlite-adapter'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-migrations'
require 'sinatra/reloader'
require 'slugify'
require 'will_paginate'
require 'will_paginate-bootstrap'
require 'will_paginate/data_mapper' 
require 'sinatra/flash'


$data_dir = ENV['OPENSHIFT_DATA_DIR'].nil? ? Dir.pwd : ENV['OPENSHIFT_DATA_DIR']

require_relative  'helpers/cloudinary'
require_relative  'helpers/blog'
require_relative  'config/blog'
require_relative  'routes/blog'
require_relative  'routes/comment'
require_relative  'routes/profile'
require_relative  'routes/category'
require_relative  'routes/public'
require_relative  'models/person'
require_relative  'models/post'

DataMapper.setup( :default, "sqlite3://#{$data_dir}/my_app.db" )
DataMapper.auto_upgrade!


person= Person.all
if person.count == 0
	new_person = Person.new(:name => 'Admin', :password => 'password', :about => 'Default admin account, edit profile then change name and password.', :avatar => '/images/avatar.png')
	new_person.save
end




class SimpleRubyBlog < Sinatra::Base
  
  enable :sessions

  set :root, File.dirname(__FILE__)

  helpers Sinatra::SimpleRubyBlog::Helpers
  
  register Sinatra::Flash
  register WillPaginate::Sinatra
  register Sinatra::SimpleRubyBlog::Routing::BlogAdmin
  register Sinatra::SimpleRubyBlog::Routing::CategoryAdmin
  register Sinatra::SimpleRubyBlog::Routing::Profile
  register Sinatra::SimpleRubyBlog::Routing::CommentControl
  register Sinatra::SimpleRubyBlog::Routing::Public

  use Rack::Static, :urls => ['/css', '/js', '/images'], :root => 'public/assests'

  WillPaginate.per_page = 8

end