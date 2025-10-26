class VwMovimento < ApplicationRecord
  self.table_name = "vw_movimentos"
  self.primary_key = "movimento_id"

  belongs_to :pessoa
  belongs_to :cartao, optional: true
  belongs_to :fatura, optional: true

  enum :tipo, { despesa: "despesa", receita: "receita" }, prefix: true

  def readonly?
    true
  end
end
