class Role
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :description, Text

  has n, :persons, :through => Resource
  has 1.0/0, :permissions, :through => Resource
end