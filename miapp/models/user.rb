class User < ActiveRecord::Base
    validates_uniqueness_of :name
    has_one :progress
    has_many :suggestions
end
