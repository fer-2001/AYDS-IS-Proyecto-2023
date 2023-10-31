# frozen_string_literal: true

class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :progress
end
