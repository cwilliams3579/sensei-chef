class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = Recipe.all
    @chefs = Chef.all
  end

  def show

  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end
end
