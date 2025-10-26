class Pessoa < ApplicationRecord
  has_many :despesas, dependent: :restrict_with_error
  has_many :despesas_fixas, dependent: :restrict_with_error
  has_many :receitas, dependent: :restrict_with_error

  validates :nome, presence: true
  validates :documento, uniqueness: true, allow_nil: true
  validates :ativo, inclusion: { in: [ true, false ] }

  scope :ativas, -> { where(ativo: true) }
end
