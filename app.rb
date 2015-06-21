require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-sqlite-adapter'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-migrations'
DataMapper.setup( :default, "sqlite3://#{Dir.pwd}/my_app.db" )

class Post
    include DataMapper::Resource
 
    property :slug       , String   , key: true, unique_index: true, default: lambda { |resource,prop| resource.title.downcase.gsub " ", "-" }
    property :title      , String   , required: true
    property :body       , Text     , required: true
    property :created_at , DateTime
    property :updated_at , DateTime
end
 
Post.auto_upgrade!

class HelloWorldApp < Sinatra::Base
	get '/create' do
	  Post.create title: "new post 2", slug: "test2", body: "test"
	  Post.create title: "new post 3", slug: "test3", body: "test"
	end


	get '/' do
	  @posts = Post.all
	  erb :index 
	end
end