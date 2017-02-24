require 'rails_helper'

RSpec.describe Recipe, type: :model do
  def setup
    @recipe = Recipe.new(name: "vegetable", description: "great vegetable recipe")
  end

  scenario "recipe should be valid" do
    assert @recipe.valid?
  end

  scenario "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end

  scenario "description should be present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end

  scenario "description shouldn't be less than 5 characters" do
    @recipe.description = "a" * 3
    assert_not @recipe.valid?
  end

  scenario "description shouldn't be more than 500 characters" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end
end
