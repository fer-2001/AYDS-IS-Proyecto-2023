class Progress < ActiveRecord::Base
  belongs_to :user

  def check_and_update_progress(user, selected_option)
    if selected_option.correct
      user.progress.correct_answers += 1
      user.progress.points += 1
    else
      user.progress.incorrect_answers += 1
      user.progress.lose_points += 1
    end
  end
end
