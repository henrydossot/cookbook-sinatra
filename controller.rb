require_relative 'view'
require_relative 'recipe'
require_relative 'parsing'
require 'open-uri'
require 'nokogiri'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_recipes
  end

  def create
    # 1. Get description from view
    description = @view.ask_user_for_description
    name = @view.ask_user_for_name
    # 2. Create new task
    recipe = Recipe.new(name, description,'','',false)
    # 3. Add to repo
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # 1. Display list with indices
    display_recipes
    # 2. Ask user for index
    index = @view.ask_user_for_index
    # 3. Remove from repository
    @cookbook.remove_recipe(index)
  end

  def import
    # 1. Get description from view
    number_recipes = 0
    array = []
    ingredient = @view.ask_user_ingredient_for_recipe
    # Scraping all the recipes for an ingredient
    filepath = "http://www.letscookfrench.com/recipes/find-recipe.aspx?type=all&aqt=#{ingredient}"
#    filepath = "#{ingredient}.html"
    document = Parsing.new(filepath).parsing_html_page
    document.search('.m_titre_resultat a').each do |element|
      h = {}
      h[:recipe] = element.text.strip
      h[:url] = element.attribute('href').value
      array << h
      number_recipes += 1
    end
    # Ask to the user to choose the recipe to scrape
    @view.display_number_recipes(ingredient, number_recipes)
    array.each_with_index do |recipe, index|
    @view.display_recipes_choices(index.to_i + 1, recipe[:recipe])
    end
    recipe_index = @view.import_recipe_index
    @view.display_recipe_to_import(array[recipe_index][:recipe])
    # Srape the choosen recipe
   filepath = "http://www.letscookfrench.com#{array[recipe_index][:url]}"
#    filepath = "#{array[recipe_index][:recipe]}.html"
    document = Parsing.new(filepath).parsing_html_page
#document.search('.m_title .fn', '.m_content_recette_info', '.m_content_recette_ingredients', '.m_avec_substitution', '.m_content_recette_todo').each do |element|
#@view.display_recipe(element.text.strip.gsub(/\s{3,}/, ' '))
#end
    # Add choosen recipe to cookbook
    cooking_time = document.search('.m_content_recette_info').text.strip.gsub(/\s{3,}/, ' ').gsub('Preparation time : ', '')
    name = array[recipe_index][:recipe]
    description = document.search('.m_content_recette_ingredients').text.strip.gsub(/\s{3,}/, ' ').chars.first(70).join + "..."
    difficulty = document.search('.m_content_recette_breadcrumb').text.strip.gsub(/\s{3,}/, ' ').split("-")[1].strip
    recipe = Recipe.new(name, description, cooking_time, difficulty, false)
    @cookbook.add_recipe(recipe)
  end

  def mark_recipe_as_test
    display_recipes
    # 2. Ask user for index
    index = @view.ask_user_for_index
    # 3. Remove from repository
    @cookbook.modify_recipe_done_true(index)
  end

  private

  def display_recipes
    # 1. Fetch tasks from repo
    recipes = @cookbook.all
    # 2. Send them to view for display
    @view.display(recipes)
  end
end
