class Recipe
attr_reader :name, :description, :prep_time, :done, :rating

  def initialize(name, description, prep_time, rating, done = false)
    @name = name
    @description = description
    @prep_time = prep_time
    @done = done
    @rating = rating
  end

  def done!
    @done = true
  end
end
