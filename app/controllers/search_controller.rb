class SearchController < ApplicationController
  protect_from_forgery :only => [:update, :delete, :create]
  def auto_complete_for_recipe_description
    criteria = '%' + params[:recipe][:description] + '%'
    @recipes = Recipe.find(:all, 
                    :conditions=>["title like ? OR description like ?",criteria, criteria],
                    :order=>'title desc', :limit=>10)
    render :partial=> "recipes" 
  end

  def index
    
    unless params[:recipe].nil?
     @recipe = Recipe.find_by_title(params[:recipe][:description])
      redirect_to :controller=>"recipes", :action=>"view", :id=>@recipe
    end
  end

 
end
