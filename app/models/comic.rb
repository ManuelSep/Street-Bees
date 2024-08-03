class Comic < ApplicationRecord
  validates :title, presence: true
  validates :cover_url, presence: true
  validates :marvel_id, presence: true, uniqueness: true
  validates :upvotes, :integer, default: 0
end
