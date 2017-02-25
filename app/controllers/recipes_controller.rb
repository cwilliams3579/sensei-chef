class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

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

  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.first
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
      #
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
    params.require(:recipe).permit(:name, :description, :image)
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end
end
