class Post
    include DataMapper::Resource
 
    property :slug       , String   , key: true, unique_index: true, default: lambda { |resource,prop| resource.title.downcase.gsub " ", "-" }
    property :title      , String   , required: true
    property :draft      , Integer
    property :template      , String 
    property :image      , Text 
    property :position   , Text 
    property :body       , Text     , required: true
    property :created_at , DateTime
    property :updated_at , DateTime
	belongs_to :person
	has n, :categories, :through => Resource
	has n, :tags, :through => Resource
    has n, :comments
    has 1, :stat
    has 1, :featured
end
class Featured
   include DataMapper::Resource
 
   property :id, Serial

   has n, :posts, :through => Resource
end