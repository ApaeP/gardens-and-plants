class PlantTag < ApplicationRecord
  belongs_to :tag
  belongs_to :plant
  validates :plant, uniqueness: { scope: :tag }
end
