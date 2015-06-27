class Role
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :description, Text

  has n, :permissions, :through => Resource
end