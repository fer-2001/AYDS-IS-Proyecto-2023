class Question < ActiveRecord::Base
    has_and_belongs_to_many :users
    has_many :options
  
    validate :validate_option_count
  
    private
  
    def validate_option_count
      errors.add(:options, "5 or more options") unless options.size <= 4
    end
  end