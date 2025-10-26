class VwParcelaStatus < ApplicationRecord
  self.table_name = "vw_parcelas_status"
  self.primary_key = "id"

  belongs_to :pessoa
  belongs_to :cartao
  belongs_to :despesa
  belongs_to :fatura, optional: true

  enum :situacao_pagamento, {
    em_aberto: "em_aberto",
    parcialmente_quitada: "parcialmente_quitada",
    quitada: "quitada"
  }, prefix: true

  def readonly?
    true
  end
end
