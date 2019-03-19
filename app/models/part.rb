class Part < ApplicationRecord
  has_and_belongs_to_many :boxes
  serialize :external_ids, Hash

  validates :part_sku, uniqueness: true
end
