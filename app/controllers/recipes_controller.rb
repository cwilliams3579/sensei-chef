class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy, :like]
  before_action :require_user, except: [:index, :show, :like]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_user_like, only: [:like]

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
    @chef = current_chef
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

  def like
    like = Like.create(like: params[:like], chef: current_chef, recipe: @recipe)
    if like.valid?
      flash[:notice] = "Your selection was succesful"
      redirect_to :back
    else
      flash[:danger] = "You can only like/dislike a recipe once"
      redirect_to :back
    end
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

  def require_user_like
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to signup_path
    end
  end
end
