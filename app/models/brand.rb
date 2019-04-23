class Brand < ApplicationRecord
  has_many :shops, -> { order(position: :asc) }, inverse_of: :brand
  validates :name, presence: true, length: { maximum: 20 }
end
