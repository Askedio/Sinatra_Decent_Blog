module Sinatra::SimpleRubyBlog::Helpers::Routes

  def default_data
    {
      :title => params[:title],
      :description => params[:description]
    }
  end

  def default_item
    {
     :id => params[:id]
    }
  end

  def default_index
   {
     :page => params[:page]
   }
  end

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
    help_redirect(model, model.update(d))
    redirect "/#{slug}/edit/#{params[:id]}"
  end

  def do_create model, slug, d
    saved = model.create(d)
    help_redirect(model, saved)
    redirect "/#{slug}/edit/#{saved.id}"
  end

  def help_redirect model, check
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
    show_template(tpl, lay)
  end

  def show_template tpl, lay
    erb :"#{tpl}", :layout => :"#{lay}"   
  end
end