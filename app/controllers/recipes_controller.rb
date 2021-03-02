# frozen_string_literal: true

# Controller for Recipes
class RecipesController < ApplicationController
  def index
    @recipes = ContentfulService.new.all_recipes
  end

  def show
    @recipe = ContentfulService.new.find_recipe(params[:id])
  end
end
