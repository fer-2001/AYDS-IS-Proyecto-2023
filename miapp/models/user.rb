class User < ActiveRecord::Base
  validates_uniqueness_of :name
  validates :name, presence: true
  validates :pass, presence: true, format: { with: /\A(?=.*[A-Z])(?=.*\d)/, message: "La contraseña contener al menos una letra mayúscula y un número" }
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

  
  ROLES = {
    clasificado: 'Clasificado',
    novato: 'Novato',
    finalista: 'Finalista',
    campeon: 'Campeon',
  }.freeze

  attribute :role, :string, default: 'clasificado'

  validates :role, inclusion: { in: ROLES.values }

  def role=(value)
    self[:role] = ROLES.key(value.to_s).to_s
  end

  def check_lifes
    lifes == 0
  end

  def role
    ROLES[self[:role].to_sym]
  end

   def update_fields(option)
    if option.correct
      self.points += option.question.cantPoints
      self.streak += 1
      self.coins += 5
      if self.lifes<5
        self.lifes += 1 
      end
    elsif
      self.lifes -= 1
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

  def buy_card(card)
    if self.coins >= card.price && card.available
      self.coins -= card.price
      card.update(available: false, user_id: self.id)
      save
      return true  # La compra fue exitosa
    else
      return false  # No se pudo comprar la carta
    end
  end
end
