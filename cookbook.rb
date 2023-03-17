require "csv"
require_relative "recipe"

class Cookbook
  def initialize(csv_file)
    @recipes = [] # <--- <Recipe> instances
    @csv_file = csv_file
    load_csv
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_to_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save_to_csv
  end

  def all
    @recipes
  end

  def mark_recipe_as_done(index)
    recipe = @recipes[index]
    recipe.done!
    save_to_csv
  end

  private

  def save_to_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << ["name", "description", "prep_time", "done", "rating"]
      @recipes.each do |recipe|
        csv << [ recipe.name, recipe.description, recipe.prep_time, recipe.done?, recipe.rating]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      done = row[:done] == "true" ? true : false
      @recipes << Recipe.new(name: row[:name], description: row[:description], prep_time: row[:prep_time], done: done, rating: row[:rating])
    end
  end
end
