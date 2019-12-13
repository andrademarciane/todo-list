class Task < ApplicationRecord
  belongs_to :board
  has_many :steps, dependent: :destroy

  validates :name, presence: true
end
