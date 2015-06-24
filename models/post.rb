class Post
    include DataMapper::Resource
 
    property :slug       , String   , key: true, unique_index: true, default: lambda { |resource,prop| resource.title.downcase.gsub " ", "-" }
    property :title      , String   , required: true
    property :draft      , Integer
    property :image      , Text 
    property :position   , Text 
    property :body       , Text     , required: true
    property :created_at , DateTime
    property :updated_at , DateTime
	belongs_to :person
	has n, :categories, :through => Resource
	has n, :tags, :through => Resource
  has n, :comments
end
class Category
   include DataMapper::Resource
 
   property :id, Serial
   property :title,          String

   has n, :posts, :through => Resource
end
class Tag
   include DataMapper::Resource
 
   property :id, Serial
   property :title,          String

   has n, :posts, :through => Resource
end
class Comment
  include DataMapper::Resource

  property :id,     Serial
  property :name      , String   , required: true
  property :email      , String   , required: true
  property :body       , Text     , required: true
  property :created_at , DateTime
  property :updated_at , DateTime

  belongs_to :post  
end