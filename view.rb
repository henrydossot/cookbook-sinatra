class View
  def display(cookbook)
    cookbook.each_with_index do |recipe, index|
      if recipe.done
      puts "#{index + 1}. [X] #{recipe.name} #{recipe.description} (#{recipe.cooking_time}) - #{recipe.difficulty}"
      else
      puts "#{index + 1}. [ ] #{recipe.name} #{recipe.description} (#{recipe.cooking_time}) - #{recipe.difficulty}"
      end
    end
  end

  def ask_user_for_description
    puts 'What recipe do you want to create'
    gets.chomp
  end

  def ask_user_for_index
    puts 'Index?'
    gets.chomp.to_i - 1
  end

  def ask_user_for_name
    puts 'name?'
    gets.chomp
  end

  def ask_user_ingredient_for_recipe
    puts 'What ingredient would you like a recipe for?'
    gets.chomp
  end

  def display_number_recipes(ingredient, number_recipes)
    puts "Looking for #{ingredient} on LetsCookFrench... #{number_recipes} results found!"
  end

  def display_recipes_choices(index, recipe)
    puts "#{index}. #{recipe}"
  end

#def display_recipe(element)
#puts element
#puts ''
#end

  def import_recipe_index
    puts "Please type a number to choose which recipe to import"
    gets.chomp.to_i - 1
  end

  def display_recipe_to_import(recipe)
    puts "Importing \"#{recipe}"
    puts "import recipe"
    puts ''
  end
end
