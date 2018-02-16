class Rocket < ApplicationRecord
  has_many :pads,through: :rocket_pads, dependent: :destroy
end
