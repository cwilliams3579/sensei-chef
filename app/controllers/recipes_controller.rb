class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def search
    if params[:search].present?
      @recipes = Recipe.search(params[:search])
    else
      @recipes = Recipe.all
    end
  end


  def index
    @recipes = Recipe.all
    @chefs = Chef.all
  end

  def show
    @comment = Comment.new
    @comments = @recipe.comments.paginate(page: params[:page], per_page: 5)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_chef
    if @recipe.save
      flash[:notice] = "Recipe was created successfully"
      redirect_to recipe_path(@recipe)
    else
      flash.now[:danger] = "Recipe was not created"
      render 'new'
    end
  end

  def edit

  end

  def update
    if @recipe.update(recipe_params)
      flash[:notice] = "Recipe was updated successfully!"
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  def destroy
    @recipe.destroy
    flash[:success] = "Recipe deleted successfully"
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :image, ingredient_ids: [])
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def require_same_user
    if current_chef != @recipe.chef and !current_chef.admin?
      flash[:danger] = "You can only edit or delete your own recipes!"
      redirect_to recipes_path
    end
  end
end
