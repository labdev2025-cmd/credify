class Despesa < ApplicationRecord
  belongs_to :pessoa
  belongs_to :cartao
  belongs_to :categoria, optional: true

  has_many :parcelas, class_name: "DespesaParcela", dependent: :destroy

  validates :descricao, :data_compra, :valor_total, presence: true
  validates :valor_total, numericality: { greater_than: 0 }
  validates :numero_parcelas, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
