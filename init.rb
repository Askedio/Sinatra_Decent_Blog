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
require 'builder' 
#require 'mailgun'
require 'erb'

require_relative  'helpers/init'
require_relative  'config/init'
require_relative  'routes/init'
require_relative  'models/init'

DataMapper.setup( :default, "sqlite3://#{$data_dir}/my_app.db" )
DataMapper.auto_upgrade!

require_relative  'seeds/init'

include ERB::Util
require 'faraday'
