class Post
    include DataMapper::Resource
 
    property :slug       , String   , key: true, unique_index: true, default: lambda { |resource,prop| resource.title.downcase.gsub " ", "-" }
    property :title      , String   , required: true
    property :body       , Text     , required: true
    property :created_at , DateTime
    property :updated_at , DateTime
end
 
Post.auto_upgrade!