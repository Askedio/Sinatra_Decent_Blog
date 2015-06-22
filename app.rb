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

DataMapper.setup( :default, "sqlite3://../../../data/my_app.db" )

require_relative  'helpers'
require_relative  'routes/blog'
require_relative  'routes/profile'
require_relative  'routes/public'
require_relative  'models/person'
require_relative  'models/post'

DataMapper.auto_upgrade!

person= Person.all
if person.count == 0
	new_person = Person.new(:name => 'Will', :password => 'Willpw', :about => '<a href="mailto:gcphost@gmail.com">William</a> has been a full-stack web developer for over a decade. He\'s worked with several start-ups, universities, small businesses, and one fortune 500 company.</p><p>After 11 years of running a successful software company he\'s decided to branch out with <a href="https://github.com/gcphost">open source projects</a>.</p><p><a href="mailto:gcphost@gmail.com">William</a> is currently available for contract work related to HTML/CSS/jQuery/PHP/Laravel.</p><ul class="pull-right social-icons icon-rounded  list-unstyled list-inline"> <li><a href="https://twitter.com/asked_io"><i class="fa fa-twitter"></i></a></li> <li><a href="https://github.com/gcphost"><i class="fa fa-github"></i></a></li> </ul><div class="clearfix"></div>', :avatar => '/images/avatar.png')
	new_person.save
	new_person = Person.new(:name => 'Abe', :password => 'Abepw', :about => 'Abe is one cool dude!</p>', :avatar => '/images/avatar_abe.png')
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