class Question < ActiveRecord::Base
 has_one :option
 has_and_belongs_to_many :user
end
