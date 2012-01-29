class RecipesController < ApplicationController
  protect_from_forgery :only => [:update, :delete, :create]
  # auto_complete_for :title, :description
  # GET /recipes
  # GET /recipes.xml
  def index
    @recipes = Recipe.find(:all)
    
    unless params[:recipeSearch].nil?
      @recipe = Recipe.find_by_title(params[:recipeSearch][:description])
      #params[:recipe][:description] = ''
      redirect_to :controller=>"recipes", :action=>:show, :id=>@recipe
      
    else
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @recipes }
      end
    end
  end
  
  # GET /recipes/1
  # GET /recipes/1.xml
  def show
    @recipe = Recipe.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @recipe }
    end
  end
  
  # GET /recipes/new
  # GET /recipes/new.xml
  def new
    @recipe = Recipe.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @recipe }
    end
  end
  
  # GET /recipes/1/edit
  def edit
    @recipe = Recipe.find(params[:id])
  end
  
  # POST /recipes
  # POST /recipes.xml
  def create
    @recipe = Recipe.new(params[:recipe])
    
    respond_to do |format|
      if @recipe.save
        flash[:notice] = 'Recipe was successfully created.'
        format.html { redirect_to(@recipe) }
        format.xml  { render :xml => @recipe, :status => :created, :location => @recipe }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /recipes/1
  # PUT /recipes/1.xml
  def update
    @recipe = Recipe.find(params[:id])
    
    respond_to do |format|
      if @recipe.update_attributes(params[:recipe])
        flash[:notice] = 'Recipe was successfully updated.'
        format.html { redirect_to(@recipe) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /recipes/1
  # DELETE /recipes/1.xml
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    
    respond_to do |format|
      format.html { redirect_to(recipes_url) }
      format.xml  { head :ok }
    end
  end
 
 def search
    
    unless params[:recipeSearch].nil?
      @recipe = Recipe.find_by_title(params[:recipeSearch][:description])
      #params[:recipe][:description] = ''
      unless @recipe.nil?
        redirect_to :controller=>"recipes", :action=>"show", :id=>@recipe
        
      else
        flash[:notice] = "No recipes found, try the list instead"
        redirect_to :controller=>"recipes", :action=>"index"

      end
    else
      @recipes = Recipe.find(:all)
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @recipes }
        redirect_to :controller=>"recipes", :action=>"index"
      end
      
    end
  end
 
  # def auto_complete_for_recipe_description
  #search = params[:recipe][:description]
  #recipes = Recipe.search(search) unless search.blank?
  #render :partial => "live/search" 
  #end
  def auto_complete_for_recipeSearch_description
    criteria = '%' + params[:recipeSearch][:description] + '%'
    @recipes = Recipe.find(:all, 
                           :conditions=>["title like ? OR description like ?",criteria, criteria],
    :order=>'title desc', :limit=>10)
    render :partial=> "recipes" 
  end
  
 
end
