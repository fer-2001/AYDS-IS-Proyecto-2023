class Report < ActiveRecord::Base
  validates :description, presence: {strict: true}
  validates_presence_of :ide
  validates :ide, numericality: { only_integer: true }
  belongs_to :user
end
