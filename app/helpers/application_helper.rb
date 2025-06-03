require 'fuzzy_match'

module ApplicationHelper
  def find_cuisine(user_input)
    fuzzy = FuzzyMatch.new(CUISINES, threshold: 0.8) 
    match = fuzzy.find(user_input.strip.capitalize)

    CUISINES.include?(match) ? match : nil 
  end
end