require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-sqlite-adapter'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-migrations'
require 'sinatra/reloader'
require 'slugify'

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
    new_post = Post.new(:title => params[:title], :slug => params[:title].slugify, :body => params[:body])
    if new_post.save
      redirect '/'
    else
      new_post.errors.each do |e|
       puts e
      end
      halt 500
    end
  end

  post '/edit/:id' do
    post ||= Post.get(params[:id]) || halt(404)
    if post.update(:title => params[:title], :slug => params[:title].slugify, :body => params[:body])
      redirect '/'
    else
      new_post.errors.each do |e|
       puts e
      end
      halt 500
    end
  end


  get '/edit/:id' do
    post ||= Post.get(params[:id]) || halt(404)
    @post = Post.first
    erb :create 
  end

  get '/delete/:id' do
    post ||= Post.get(params[:id]) || halt(404)
    halt 500 unless post.destroy
    redirect '/'
  end 

  get '/posts/:id' do
    post ||= Post.get(params[:id]) || halt(404)
    @post = Post.first
    erb :details 
  end

  get '/' do
    @posts = Post.all
    erb :index 
  end
end