require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'cookbook'    # You need to create this file!
require_relative 'controller'  # You need to create this file!
require_relative 'router'
require_relative 'recipe'

#set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

# class Recipe
#   attr_reader :description, :name, :cooking_time, :difficulty
#   attr_accessor :done
#   def initialize(name, description)
#     @name = name
#     @description = description
#   end
#   def done?
#     @done
#   end
# end


recipes_list = [
  ["pizza", "de la pate et de la sauce tomate"],
  ["pizza", "de la pate et de la sauce tomate, encore"]
]

recipes = []

recipes_list.each do |recipe_array|
  recipes << Recipe.new(recipe_array[0], recipe_array[1])
end



get '/' do
  @recipes = recipes
  erb :list
end

get '/new_recipe' do
  erb :new_recipe
end

get '/new_recipe_creates' do
  recipes << Recipe.new(params[:name], params[:description])
  erb :new_recipe_creates
end


#get '/about' do
#  erb :about
#end#

#get '/team/:username' do
##  binding.pry
#  puts params[:username]
#  "The username is #{params[:username]}"
#end
