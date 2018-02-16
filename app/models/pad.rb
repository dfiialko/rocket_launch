class Pad < ApplicationRecord
  validates :name,uniqueness: true
  validates :map, presence: true
  has_and_belongs_to_many :agencies
  has_many :rockets,through: :rocket_pads
end
