require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    CSV.foreach(@csv_file_path) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4])
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv
  end

  def modify_recipe_done_true(recipe_index)
    @recipes[recipe_index].done = true
    save_csv
  end

  private

  def save_csv
    # 1 ouverture du CSV
    CSV.open(@csv_file_path, "wb") do |csv|
      # 2 prendre TOUTES les recettes et
      @recipes.each do |recipe|
        # 3 pour CHAQUE recette, la mettre dans le CSV
        csv << [recipe.name, recipe.description, recipe.cooking_time, recipe.difficulty, recipe.done]
      end
    end
  end
end
