class Cartao < ApplicationRecord
  has_many :faturas, dependent: :restrict_with_error
  has_many :despesas, dependent: :restrict_with_error
  has_many :despesas_fixas, dependent: :restrict_with_error

  validates :apelido, presence: true, uniqueness: true
  validates :fechamento_dia, :vencimento_dia, presence: true,
            numericality: { only_integer: true, in: 1..31 }
  validates :ativo, inclusion: { in: [ true, false ] }
  validates :timezone, presence: true
  validate :fechamento_e_vencimento_diferentes

  private

  def fechamento_e_vencimento_diferentes
    if fechamento_dia == vencimento_dia
      errors.add(:vencimento_dia, "não pode ser igual ao dia de fechamento")
    end
  end
end
