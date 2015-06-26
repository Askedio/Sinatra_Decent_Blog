require 'rubygems'
require 'bundler'
require 'rack'
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
require 'tilt/erb'
require 'faraday'
require 'sinatra/r18n'
Bundler.require

Dir.glob('./{models,helpers,routes,config}/*.rb').each { |file| require file }

DataMapper.setup( :default, "sqlite3://#{$data_dir}/my_app.db" )
DataMapper.auto_upgrade!

Dir.glob('./seeds/*.rb').each { |file| require file }

require './app'
map('/') { run SimpleRubyBlog }