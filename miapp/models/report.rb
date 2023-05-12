class Report < ActiveRecord::Base
  validates :descripcion, presence: {strict: true}
  validates_presence_of :ide
  validates :ide, numericality: { only_integer: true }
end
