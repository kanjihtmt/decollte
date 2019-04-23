class Shop < ApplicationRecord
  belongs_to :brand
  acts_as_list scope: :brand
  validates :name, presence: true, length: { maximum: 100 }
end
