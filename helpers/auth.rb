module Sinatra::SimpleRubyBlog::Helpers::Auth
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
    return session[:username].nil? ? false : true
  end

  def unauthorize
    session.destroy
  end

end