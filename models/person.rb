# TO-DO: Fix bcrypt on local install so we can secure passwords
class Person
  include DataMapper::Resource

  property :id, Serial
  property :slug, String
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