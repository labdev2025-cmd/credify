class DespesaParcela < ApplicationRecord
  belongs_to :despesa
  belongs_to :fatura, optional: true
  has_many :alocacoes_pagamentos, dependent: :destroy
  has_many :receitas, through: :alocacoes_pagamentos

  validates :numero_parcela, :total_parcelas, :valor_parcela, :competencia, presence: true
  validates :valor_parcela, numericality: { greater_than: 0 }
  validates :numero_parcela, numericality: { greater_than_or_equal_to: 1 }
  validates :total_parcelas, numericality: { greater_than_or_equal_to: 1 }
  validates :status_fatura, inclusion: { in: %w[a_faturar faturada paga estornada] }
end
