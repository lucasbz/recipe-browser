# frozen_string_literal: true

# Controller for Recipes
class RecipesController < ApplicationController
  def index
    contentful = ContentfulService.new
    @recipes = contentful.retrieve_recipes
  end

  def show; end
end
