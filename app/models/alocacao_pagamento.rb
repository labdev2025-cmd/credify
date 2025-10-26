class AlocacaoPagamento < ApplicationRecord
  belongs_to :receita
  belongs_to :despesa_parcela

  validates :valor_alocado, numericality: { greater_than: 0 }
  validates :receita_id, uniqueness: { scope: :despesa_parcela_id }
end
