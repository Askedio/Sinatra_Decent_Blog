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

      def do_error data
        error = nil
        data.each do |e|
         error = "#{error}  #{e}"
        end
        flash[:error] = error
      end

      def auth?
        if authorized? 
         return true
        else
          flash[:redirect_to] = request.fullpath
          redirect '/login'
        end
      end

      def login name, pass
        if !name.empty? && !pass.empty?
         # TO-DO: Fix bcrypt on local install so we can secure passwords
          user = Person.first(:name => name, :password => pass)
          if user
            session[:username] = user.name
            return true
         end
        end
        flash[:error] = t.login.errors.failed
        false
      end

      def authorized?
        return session[:username].nil?
      end

      def unauthorize
        session.destroy
      end

    end
  end
end