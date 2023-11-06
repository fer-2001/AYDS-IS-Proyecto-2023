# frozen_string_literal: true

require 'bcrypt'

class User < ActiveRecord::Base
  validates_uniqueness_of :name
  validates :name, presence: true
  validates :lifes, presence: true
  validates :lifes, numericality: { less_than_or_equal_to: 5, greater_than_or_equal_to: 0 }
  validates :streak, presence: true
  validates :points, presence: true
  validates :role, presence: true
  has_one :progress
  has_one :leadearboard
  has_and_belongs_to_many :question
  has_many :suggestions
  has_many :reports
  has_many :responses
  has_many :options, through: :responsescard
  has_many :cards
  has_secure_password

  JUGADORES = {
    1 => 'Messi', 2 => 'Dibala', 3 => 'Romero', 4 => 'Martinez', 5 => 'Molina', 6 => 'Otamendi', 7 => 'Tagliafico',
    8 => 'Fernandez', 9 => 'De Paul', 10 => 'Mac Allister', 11 => 'Di Maria', 12 => 'Alvarez', 13 => 'Scaloni'
  }.freeze

  def authenticate(password)
    BCrypt::Password.new(password_digest) == password
  end

  ROLES = {
    clasificado: 'Clasificado',
    novato: 'Novato',
    finalista: 'Finalista',
    campeon: 'Campeon'
  }.freeze

  attribute :role, :string, default: 'clasificado'

  validates :role, inclusion: { in: ROLES.values }

  def role=(value)
    self[:role] = ROLES.key(value.to_s).to_s
  end

  def check_lifes
    lifes.zero?
  end

  def role
    ROLES[self[:role].to_sym]
  end

  def update_fields(option)
    if option.correct
      self.points += option.question.cantPoints
      self.streak += 1
      self.coins += 5
      self.lifes += 1 if lifes < 5
    elsif self.lifes -= 1
    end
    save
  end

  def update_role
    if points > 120
      new_role = 'Campeon'
    elsif points > 50
      new_role = 'Finalista'
    elsif points > 10
      new_role = 'Novato'
    end

    if new_role && ROLES.values.include?(new_role)
      self.role = new_role
      save
      true
    else
      false
    end
  end

  def generate_card(name, position, price, available)
    Card.create(name: name, position: position, price: price, available: available)
  end


  def buy_card(card_number)
    card_name = JUGADORES[card_number]
    if cards.where(name: card_name, user_id: id).count.positive?
      return false
    end
    return false unless self.coins >= 10
    card = generate_card(card_name, 'Posición', 10, true)
    self.coins -= 10
    card.update(available: false, user_id: id)
    save
    true
  end

  def set_card_by_name
    position = JUGADORES.key(card)
    new_card_name = "carta#{position}" if position
  
    if new_card_name && self.card != new_card_name
      self.card = new_card_name
      save
    end
  end
  
  def card_image_url
    "/image/#{card}.jpg"
  end
end