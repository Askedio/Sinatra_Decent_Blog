class Person
   include DataMapper::Resource
   property :id, Serial
   property :slug, String   ,  unique_index: true, default: lambda { |resource,prop| resource.title.downcase.gsub " ", "-" }
   property :name      , String   , required: true
   property :avatar      , String
   property :password      , String
   property :title      , String
   property :about      , Text 
   has n, :posts
end