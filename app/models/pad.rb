class Pad < ApplicationRecord
  has_and_belongs_to_many :agencies
  has_many :rockets,through: :rocket_pads
end
