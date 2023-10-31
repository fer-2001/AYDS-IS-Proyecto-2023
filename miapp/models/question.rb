# frozen_string_literal: true

class Question < ActiveRecord::Base
  validates :question, presence: true
  validates :difficult, presence: true
  validates :cantPoints, presence: true
  validates :curiosities, presence: true
  validate :validate_option_count
  has_and_belongs_to_many :users
  has_many :options


  def validate_option_count
    errors.add(:options, '5 or more options') unless options.size <= 4
  end
end
