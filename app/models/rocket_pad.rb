class RocketPad < ApplicationRecord
  belongs_to :rocket, dependent: :destroy
  belongs_to :pad , dependent: :destroy
end
