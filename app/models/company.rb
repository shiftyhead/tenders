class Company < ApplicationRecord
  has_many :tenders
  validates :name, presence: true
end
