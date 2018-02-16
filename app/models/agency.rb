class Agency < ApplicationRecord
  has_many :rockets
  has_many :missions
  has_and_belongs_to_many :pads
end
