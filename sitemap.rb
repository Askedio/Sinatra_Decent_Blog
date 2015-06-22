require 'rubygems'
require './app'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://asked.io'
SitemapGenerator::Sitemap.create do
  add '/', :changefreq => 'daily', :priority => 0.9

  @posts = Post.all()
  @posts.each do |post|
	  add '/posts/' + post.slug, :changefreq => 'weekly'
  end
end
#SitemapGenerator::Sitemap.ping_search_engines