require 'rubygems'
require 'rack'
require 'dm-core'
require 'dm-sqlite-adapter'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-migrations'
require "sinatra"
require "sinatra/config_file"
require 'sitemap_generator'
Dir.glob('./{models,helpers,routes,config}/*.rb').each { |file| require file }

DataMapper.setup( :default, "sqlite3://#{$data_dir}/my_app.db" )

config_file 'config/config.yml'

set :run, false

SitemapGenerator::Sitemap.default_host = settings.site_url
SitemapGenerator::Sitemap.create do
  add '/', :changefreq => 'daily', :priority => 0.9

  @posts = Post.all()
  @posts.each do |post|
	  add '/' + post.slug, :changefreq => 'weekly'
  end
end
#SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks