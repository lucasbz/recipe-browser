# frozen_string_literal: true

# A delicious recipe
class Recipe < ContentfulModel::Base
  self.content_type_id = 'recipe'

  has_one :chef
end
