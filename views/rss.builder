xml.instruct! :xml, :version => '1.0'
xml.rss :version => "2.0" do
  xml.channel do
    xml.title $site_title
    xml.description $site_slogan
    xml.link $site_url

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.link "#{$site_url}/posts/#{post.slug}"
        xml.description post.body
        xml.pubDate Time.parse(post.created_at.to_s).rfc822()
        xml.guid "#{$site_url}/posts/#{post.slug}"
      end
    end
  end
end