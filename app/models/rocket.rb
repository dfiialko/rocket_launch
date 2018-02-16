class Rocket < ApplicationRecord
  belongs_to :agency
  has_many :pads,through: :rocket_pads
end
