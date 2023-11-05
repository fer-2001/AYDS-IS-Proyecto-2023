# frozen_string_literal: true

# Class Card
class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :progress
end
