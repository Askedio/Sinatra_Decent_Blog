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