class Categoria < ApplicationRecord
  has_many :despesas, dependent: :nullify
  has_many :despesas_fixas, dependent: :nullify
  has_many :receitas, dependent: :nullify

  enum :tipo, { despesa: "despesa", receita: "receita" }, prefix: true

  validates :nome, presence: true
  validates :tipo, presence: true, inclusion: { in: tipos.keys }
end
