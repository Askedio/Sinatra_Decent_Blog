require 'rubygems'
require './app'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = settings.site_url
SitemapGenerator::Sitemap.create do
  add '/', :changefreq => 'daily', :priority => 0.9

  @posts = Post.all()
  @posts.each do |post|
	  add '/' + post.slug, :changefreq => 'weekly'
  end
end