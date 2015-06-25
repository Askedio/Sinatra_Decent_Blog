class Category
   include DataMapper::Resource
 
   property :id, Serial
   property :slug, String   ,  unique_index: true, default: lambda { |resource,prop| resource.title.downcase.gsub " ", "-" }
   property :title,          String
   property :description   , Text 

   has n, :posts, :through => Resource
end