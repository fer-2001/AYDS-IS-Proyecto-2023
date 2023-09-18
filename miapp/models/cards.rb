class Leadearboard < ActiveRecord::Base
  belongs_to :user
  belongs_to :progress
end
