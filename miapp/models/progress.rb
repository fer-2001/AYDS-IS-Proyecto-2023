class Progress < ActiveRecord::Base
  belongs_to :user
  has_many :cards

  def update_progress(option, is_correct)
    if is_correct
      self.correct_answers += 1
      self.points += option.question.cantPoints
    else
      self.incorrect_answers += 1
      self.lose_points += option.question.cantPoints
    end

    self.current_question += 1
    save!
  end
end
