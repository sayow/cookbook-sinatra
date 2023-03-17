require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"

set :bind, "0.0.0.0"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

require_relative "cookbook"
require_relative "recipe"

get "/" do
  cookbook = Cookbook.new(File.join(__dir__, "recipes.csv"))
  @recipes = cookbook.all
  erb :index
end

get "/new" do
  erb :new
end

post "/recipes" do
  cookbook = Cookbook.new(File.join(__dir__, "recipes.csv"))
  recipe = Recipe.new(params[:name], params[:description])
  cookbook.add(recipe)
  redirect to "/"
end

get "/recipes/:index" do
  cookbook = Cookbook.new(File.join(__dir__, "recipes.csv"))
  cookbook.destroy(params[:index].to_i)
  redirect to "/"
end