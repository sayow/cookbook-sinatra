require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"

require_relative "cookbook"
require_relative "recipe"
require_relative 'scraper'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

COOKBOOK = Cookbook.new(File.join(__dir__, 'recipes.csv'))
SCRAPER = Scraper.new


get "/" do
  @recipes = COOKBOOK.all
  erb :index
end

get "/new" do
  erb :new
end

post '/destroy/:index' do
  COOKBOOK.remove_recipe(params[:index].to_i)
  redirect '/'
end

post "/recipes" do
  recipe = Recipe.new(params[:name],params[:description], params[:prep_time], params[:rating], params[:done])
  COOKBOOK.add_recipe(recipe)
  redirect to "/"
end

get '/search' do
  @query = params[:query]
  @recipes = SCRAPER.call(params[:query])
  erb :search
end

post '/add_recipe/:index' do
  new_recipe = Recipe.new(
    params[:name],
    params[:description],
    params[:prep_time],
    params[:prep_time],
    params[:done]
  )
  COOKBOOK.add_recipe(new_recipe)
  redirect '/'
end


