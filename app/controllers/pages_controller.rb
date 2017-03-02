class PagesController < ApplicationController

  def home
    @chef = Chef.all
    redirect_to recipes_path if logged_in?
  end
end
