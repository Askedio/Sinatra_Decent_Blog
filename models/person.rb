class Person
  include DataMapper::Resource

  property :id, Serial
  property :slug, String,  unique_index: true, default: lambda { |resource,prop| resource.title.downcase.gsub " ", "-" }
  property :name, String, required: true
  property :avatar, String
  property :password, String
  property :title, String
  property :email, String
  property :about, Text

  has n, :posts
  has 1.0/0, :roles, :through => Resource
  has 1.0/0, :permissions, :through => Resource
end


class Role
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :description, Text

  has n, :permissions, :through => Resource
end

class Permission
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :description, Text

  has n, :roles, :through => Resource
  has n, :persons, :through => Resource
end