class Report < ActiveRecord::Base
  validates :description, presence: true
  belongs_to :user
end
