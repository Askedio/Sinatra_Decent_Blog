module Sinatra
  module SimpleRubyBlog
    module Helpers

      def render_output tpl, lay='layout'
        erb :"#{tpl}", :layout => :"#{lay}"   
      end

      def featured param, post
        if (param.nil? && !post.featured.nil?)
          post.featured.destroy
          nil
        elsif !param.nil?
          Featured.new
        end
      end

      def is_number?(object)
        true if Float(object) rescue false
      end

      def add_missing array, model
        if !array.nil?
          array.each do |r|
            if !is_number?(r)
              array <<  model.create(:title => r).id
              array.delete r
            end
          end
        end
        array
      end

      def process_category new_post, cats
        if !cats.nil?
          cats.each do |cat|
          category = Category.first(:id => cat)
          if category.nil?
            category= Category.create(:title => cat)
          end
          new_post.categories << category
          end
        end
        new_post
      end

      def process_tag new_post, tags
        if !tags.nil?
          tags.each do |tag|
          tagg = Tag.first(:id => tag)
          if tagg.nil?
            tagg = Tag.create(:title => tag)
          end
          new_post.tags << tagg
          end
        end
        new_post
      end

      def do_error data
        error = nil
        data.each do |e|
         error = "#{error}  #{e}"
        end
        flash[:error] = error
      end

      def protected!
        return if auth?
          headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
          halt 401, "Not authorized\n"
      end

      def auth?
        @auth ||=  Rack::Auth::Basic::Request.new(request.env)
        if @auth.provided? && @auth.basic? && @auth.credentials
           user = Person.first(:name => @auth.credentials[0])
        end
        if user && user.password == @auth.credentials[1]
          session[:username] = user.name
          return true
        else
          response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
          throw(:halt, [401, "Not authorized\n"])
        end
      end

      def authorized?
        @auth ||=  Rack::Auth::Basic::Request.new(request.env)
        if @auth.provided? && @auth.basic? && @auth.credentials
          return true
        else
          return false
        end
      end

    end
  end
end