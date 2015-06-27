class Permission
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :description, Text

  has n, :roles, :through => Resource
  has n, :persons, :through => Resource
end