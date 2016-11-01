class Tender < ApplicationRecord
  include PgSearch
  pg_search_scope :pg_search, against: [:name, :address],:using => {tsearch: {prefix: true, any_word: true}}
  belongs_to :company
  has_many :items
end
