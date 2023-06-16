class User < ActiveRecord::Base
  validates_uniqueness_of :name
  validates :name, presence: true
  validates :pass, presence: true, format: { with: /\A(?=.*[A-Z])(?=.*\d)/, message: "La contraseña contener al menos una letra mayúscula y un número" }
  validates :lifes, presence: true
  validates :streak, presence: true
  validates :points, presence: true
  validates :role, presence: true
  has_one :progress
  has_and_belongs_to_many :question
  has_many :suggestions
  has_many :reports
  has_many :responses
  has_many :options, through: :responses
  
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

  def role
    ROLES[self[:role].to_sym]
  end
end
