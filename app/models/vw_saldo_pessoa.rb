class VwSaldoPessoa < ApplicationRecord
  self.table_name = "vw_saldos_pessoa"
  self.primary_key = "pessoa_id"

  belongs_to :pessoa

  def readonly?
    true
  end
end
