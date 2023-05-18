class Option < ActiveRecord::Base
    belongs_to :question, index: true, foreign_key: true
end
