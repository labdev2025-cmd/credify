class Fatura < ApplicationRecord
  belongs_to :cartao
  has_many :despesas_parcelas, dependent: :nullify

  validates :competencia, :data_fechamento, :data_vencimento, presence: true
  validates :status, inclusion: { in: %w[aberta fechada paga cancelada] }
  validates :valor_fechado, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  scope :abertas, -> { where(status: "aberta") }
  scope :pagas, -> { where(status: "paga") }
end
