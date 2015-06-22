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

enable :sessions

db_file = ENV['OPENSHIFT_DATA_DIR'].nil? ? Dir.pwd : ENV['OPENSHIFT_DATA_DIR']
DataMapper.setup( :default, "sqlite3://#{db_file}/my_app.db" )

require_relative  'helpers'
require_relative  'routes/blog'
require_relative  'routes/profile'
require_relative  'routes/public'
require_relative  'models/person'
require_relative  'models/post'

DataMapper.auto_upgrade!

person= Person.all
if person.count == 0
	new_person = Person.new(:name => 'Admin', :password => 'password', :about => 'Default admin account, edit profile then change name and password.', :avatar => '/images/avatar.png')
	new_person.save
end


class SimpleRubyBlog < Sinatra::Base
  set :root, File.dirname(__FILE__)

  helpers Sinatra::SimpleRubyBlog::Helpers

  register WillPaginate::Sinatra
  WillPaginate.per_page = 5

  register Sinatra::SimpleRubyBlog::Routing::BlogAdmin
  register Sinatra::SimpleRubyBlog::Routing::Profile
  register Sinatra::SimpleRubyBlog::Routing::Public

  use Rack::Static, :urls => ['/css', '/js', '/images'], :root => 'public/assests'

end