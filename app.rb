require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-sqlite-adapter'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-migrations'
require "sinatra/reloader"

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
	  erb :create 
	end

	post '/create' do
    new_post = Post.new(:title => params[:title], :slug => params[:slug], :body => params[:body])
    if new_post.save
      puts "Awesome, it works!"
    else
      new_post.errors.each do |e|
       puts e
      end
    end
	end

	get '/' do
	  @posts = Post.all
	  erb :index 
	end
end