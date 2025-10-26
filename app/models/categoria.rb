class Categoria < ApplicationRecord
  has_many :despesas, dependent: :nullify
  has_many :despesas_fixas, dependent: :nullify
  has_many :receitas, dependent: :nullify

  validates :nome, presence: true
  validates :tipo, presence: true, inclusion: { in: %w[despesa receita] }

  scope :despesas, -> { where(tipo: "despesa") }
  scope :receitas, -> { where(tipo: "receita") }
end
