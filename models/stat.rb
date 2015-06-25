class Stat
   include DataMapper::Resource
   property :id, Serial
   property :hits      , Integer
   belongs_to :post
end