class Suggestion < ActiveRecord::Base
  validates :description, presence: { strict: true }
  belongs_to :user
end
