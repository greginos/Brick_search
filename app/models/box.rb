class Box < ApplicationRecord
  has_and_belongs_to_many :parts
  serialize :external_ids, Hash

  validates :box_sku, uniqueness: true
end
