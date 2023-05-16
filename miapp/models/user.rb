class User < ActiveRecord::Base
    validates_uniqueness_of :name
    has_one :progress
    has_and_belongs_to_many :question
    has_many :suggestions
    has_many :reports
end
