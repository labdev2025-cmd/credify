class VwParcelaStatus < ApplicationRecord
  self.table_name = "vw_parcelas_status"
  self.primary_key = "id"

  belongs_to :pessoa
  belongs_to :cartao
  belongs_to :despesa
  belongs_to :fatura, optional: true

  def readonly?
    true
  end
end
