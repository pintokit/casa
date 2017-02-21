class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def normalize(original_value , min_value, max_value, should_invert)
    range = max_value - min_value
    value_in_range = original_value - min_value
    multipler = 1.0/range
    score = multipler * value_in_range

    if should_invert
      score = 1 - score
    end

    return score
  end
end
