# frozen_string_literal: true

# Class Suggestion
class Suggestion < ActiveRecord::Base
  belongs_to :user
  validates :description, presence: true
end
