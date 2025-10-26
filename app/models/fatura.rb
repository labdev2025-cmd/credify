class Fatura < ApplicationRecord
  belongs_to :cartao
  has_many :despesas_parcelas, dependent: :nullify

  enum :status, {
    aberta: "aberta",
    fechada: "fechada",
    paga: "paga",
    cancelada: "cancelada"
  }, prefix: true

  validates :competencia, :data_fechamento, :data_vencimento, presence: true
  validates :status, inclusion: { in: statuses.keys }
  validates :valor_fechado, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
