class Agency < ApplicationRecord
  has_many :missions
  has_and_belongs_to_many :pads
  validates :name,presence: true,uniqueness: true
  validates :abbrev,uniqueness: true
end
