class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  validates :movie, :list, presence: true
  validates :movie_id, uniqueness: { scope: :list_id, message: "A bookmark has been already added" }
  validates :comment, length: { minimum: 6 }
end

# class Person < ApplicationRecord
#   validates :bio, length: { maximum: 1000, too_long: "%{count} characters is the maximum allowed" }
# end
