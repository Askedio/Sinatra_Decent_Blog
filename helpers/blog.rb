module Sinatra::SimpleRubyBlog::Helpers


  def do_error data
    error = nil
    data.each do |e|
     error = "#{error}  #{e}"
    end
    flash[:error] = error
  end

  def do_delete(model, dest)
    if model.first(:id => params[:id]).destroy
      flash[:success] = true
     else
      flash[:error] = error
    end
    redirect dest
  end

  def do_edit model, slug, d
    halt(404) unless model 
    help_redirect(model, model.update(d), slug)
    redirect "/#{slug}/edit/#{params[:id]}"
  end

  def do_create model, slug, d
    saved = model.create(d)
    help_redirect(model, saved, slug)
    redirect "/#{slug}/edit/#{saved.id}"
  end

  def help_redirect model, check, slug
    if check
      flash[:success] = true
    else
      do_error model.errors
    end
  end

  def do_output model, tpl, lay = nil, title = nil, description = nil
    halt(404) unless model 
    @data = model
    render_output(tpl, lay, title, description)
  end
    
  def render_output tpl, lay = nil, title = nil, description = nil
    if lay.nil?
      lay = 'layout'
    end
    unless title.nil?
      @page_title = title
    end
    unless description.nil?
      @page_description = description
    end
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