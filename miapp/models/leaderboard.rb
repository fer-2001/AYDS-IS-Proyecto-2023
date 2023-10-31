# frozen_string_literal: true

class Leaderboard < ActiveRecord::Base
  belongs_to :user
  validates :rank, presence: true
  def self.update_rank
    # Recuperar todos los usuarios ordenados por puntos de forma descendente
    users_ordered_by_points = User.order(points: :desc)

    # Recorrer la lista ordenada y actualizar el ranking en el modelo Leaderboard
    users_ordered_by_points.each_with_index do |user, index|
      leaderboard_entry = find_or_create_by(user_id: user.id)
      leaderboard_entry.update(rank: index + 1)
    end
  end
end
