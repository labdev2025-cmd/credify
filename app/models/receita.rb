class Receita < ApplicationRecord
  belongs_to :pessoa
  belongs_to :categoria, optional: true

  has_many :alocacoes_pagamentos, dependent: :destroy
  has_many :parcelas, through: :alocacoes_pagamentos, source: :despesa_parcela

  enum :meio_pagamento, {
    pix: "pix",
    dinheiro: "dinheiro",
    transferencia: "transferencia",
    boleto: "boleto",
    outro: "outro"
  }, prefix: true, allow_nil: true

  validates :descricao, :data_recebimento, :valor, presence: true
  validates :valor, numericality: { greater_than: 0 }
end
