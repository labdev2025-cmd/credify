class Receita < ApplicationRecord
  belongs_to :pessoa
  belongs_to :categoria, optional: true

  has_many :alocacoes_pagamentos, dependent: :destroy
  has_many :parcelas, through: :alocacoes_pagamentos, source: :despesa_parcela

  validates :descricao, :data_recebimento, :valor, presence: true
  validates :valor, numericality: { greater_than: 0 }
  validates :meio_pagamento, inclusion: { in: %w[pix dinheiro transferencia boleto outro], allow_nil: true }
end
