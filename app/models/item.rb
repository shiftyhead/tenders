class Item < ApplicationRecord
  include PgSearch

  validates :tender_id, :content, :quantity, :price_one, :price_all, presence: true

  pg_search_scope :pg_search, against: [:content],:using => {tsearch: {prefix: true, any_word: true, dictionary: "russian"}}

  belongs_to :tender
end
