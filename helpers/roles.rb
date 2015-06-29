module Sinatra::SimpleRubyBlog::Helpers::Roles
  module ClassMethods
    def can perm
      roles.permissions.count(:title => perm) == 1 ? true : false
    end
  end
end