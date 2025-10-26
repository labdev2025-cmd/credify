class VwFaturaItem < ApplicationRecord
  self.table_name = "vw_fatura_itens"
  self.primary_key = "parcela_id"

  belongs_to :fatura
  belongs_to :cartao
  belongs_to :despesa
  belongs_to :pessoa

  def readonly?
    true
  end
end
