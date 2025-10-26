class Categoria < ApplicationRecord
  has_many :despesas, dependent: :nullify
  has_many :despesas_fixas, dependent: :nullify
  has_many :receitas, dependent: :nullify

  enum :tipo, { despesa: "despesa", receita: "receita" }, prefix: true

  before_validation :normalize_fields

  validates :nome, presence: true
  validates :tipo, presence: true, inclusion: { in: tipos.keys }

  private

  def normalize_fields
    self.nome = nome&.upcase&.strip
  end
end
