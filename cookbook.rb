require "csv"
require_relative "recipe"

class Cookbook
  def initialize(csv_file)
    @recipes = [] 
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

  private

  def save_to_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << ['name', 'description']
      @recipes.each do |recipe|
        csv << [ recipe.name, recipe.description]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row) do |row|
      @recipes << Recipe.new(row['name'], row['description'])
    end
  end
end
