class DespesaFixa < ApplicationRecord
  belongs_to :pessoa
  belongs_to :cartao
  belongs_to :categoria, optional: true

  validates :descricao, :valor_mensal, :dia_lancamento, :inicio_em, presence: true
  validates :valor_mensal, numericality: { greater_than: 0 }
  validates :dia_lancamento, numericality: { only_integer: true, in: 1..31 }
  validates :ativa, inclusion: { in: [ true, false ] }

  validate :periodo_valido

  private

  def periodo_valido
    if fim_em.present? && fim_em < inicio_em
      errors.add(:fim_em, "deve ser igual ou posterior à data de início")
    end
  end
end
