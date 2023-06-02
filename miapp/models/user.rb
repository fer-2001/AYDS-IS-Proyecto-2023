class User < ActiveRecord::Base
  validates_uniqueness_of :name
  validates :name, presence: true
  validates :pass, presence: true
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
  validates :role, inclusion: { in: ROLES.values }
  def role=(value)
    super(ROLES.key(value.to_s))
  end
  def role
    ROLES[super]
  end
end
