class Color < ApplicationRecord
  serialize :external_ids, Hash

  validates :rgb, uniqueness: true
end
