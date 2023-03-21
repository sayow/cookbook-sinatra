require 'nokogiri'
require 'open-uri'
require_relative "recipe"

class Scraper

  HTML = "https://www.bbcgoodfood.com/search?q="

  def call(ingredient)
    doc = URI.parse(HTML + ingredient).open
    doc_content = Nokogiri::HTML(doc)
    results = []
    doc_content.search("article.card.text-align-left.card--horizontal.card--inline.card--with-borders").first(9).each do |element|
      name = element.search("h2.heading-4").text.strip
      description = element.search(".region-clamper.line-clamper__content").text.strip
      prep_time = element.search(".terms-icons-list__text.d-flex.align-items-center").children.text.strip.sub!(/(mins).*/mi, "\\1")
      rating = element.search("span.sr-only").text.split(/of(.*?)out/)[1].strip
      results << Recipe.new(name, description, prep_time, rating)
    end
    return results
  end
end