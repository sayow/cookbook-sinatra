class Recipe
  attr_reader :name, :description, :prep_time, :done, :rating

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @prep_time = attributes[:prep_time]
    @done = attributes[:done] || false
    @rating = attributes[:rating]
  end

  def done?
    done
  end

  def done!
    @done = true
  end
end
