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
  
  def authenticate(password)
    BCrypt::Password.new(self.password_digest) == password
  end

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

  def generate_card(name, position, price, available)
    card = Card.create(name: name, position: position, price: price, available: available)
    card  # Devuelve la carta creada
  end
  

  def buy_card(card_number)
    card_name = case card_number
      when 1 then "Messi"
      when 2 then "Dibala"
      when 3 then "Romero"
      when 4 then "Martinez"
      when 5 then "Molina"
      when 6 then "Otamendi"
      when 7 then "Tagliafico"
      when 8 then "Fernandez"
      when 9 then "De Paul"
      when 10 then "Mac Allister"
      when 11 then "Di Maria"
      when 12 then "Alvarez"
      when 13 then "Scaloni"
      else return false  # Handle the case where card_number is not 1 to 13
    end
      # Verificar si el usuario ya tiene la carta
      if cards.where(name: card_name, user_id: self.id).count > 0
        return false  # El usuario ya posee la carta
      end

      if self.coins >= 10
        card = generate_card(card_name, "Posición", 10, true)
        self.coins -= 10
        card.update(available: false, user_id: self.id)
        save
        return true  # La compra fue exitosa
      else
        return false  # No se pudo comprar la carta debido a la falta de monedas
      end
  end

  def set_card_by_name
    new_card_name = case self.card
      when "Messi" then "carta1"
      when "Dibala" then "carta2"
      when "Romero" then "carta3"
      when "Martinez" then "carta4"
      when "Molina" then "carta5"
      when "Otamendi" then "carta6"
      when "Tagliafico" then "carta7"
      when "Fernandez" then "carta8"
      when "De Paul" then "carta9"
      when "Mac Allister" then "carta10"
      when "Di Maria" then "carta11"
      when "Alvarez" then "carta12"
      when "Scaloni" then "carta13"
      else nil  # Manejar el caso en el que el nombre de la carta no sea válido
    end
  
    if new_card_name
      self.card = new_card_name
      self.save if self.changed? # Guarda el usuario solo si se cambió el nombre de la carta
    end
  end
  

  # Define el método card_image_url para obtener la URL de la imagen de la carta por nombre
  def card_image_url
    "/image/#{self.card}.jpg"
  end


end
