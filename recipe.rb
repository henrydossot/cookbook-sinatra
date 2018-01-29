class Recipe
  attr_reader :description, :name, :cooking_time, :difficulty
  attr_accessor :done
  def initialize(name, description, cooking_time = '', difficulty = '', done = false)
    @name = name
    @description = description
    @cooking_time = cooking_time
    @difficulty = difficulty
    @done = done
  end
  def done?
    @done
  end
end
