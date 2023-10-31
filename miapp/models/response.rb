# frozen_string_literal: true

class Response < ActiveRecord::Base
  belongs_to :user
  belongs_to :option
end
