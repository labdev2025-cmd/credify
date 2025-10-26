class Cartao < ApplicationRecord
  has_many :faturas, dependent: :restrict_with_error
  has_many :despesas, dependent: :restrict_with_error
  has_many :despesas_fixas, dependent: :restrict_with_error

  before_validation :normalize_fields

  validates :apelido, presence: true, uniqueness: true
  validates :emissor, :bandeira, :timezone, presence: true
  validates :fechamento_dia, :vencimento_dia, presence: true,
            numericality: { only_integer: true, in: 1..31 }
  validates :ativo, inclusion: { in: [true, false] }
  validates :final_cartao,
            format: { with: /\A\d{4}\z/, message: I18n.t("errors.messages.last_four_digits") },
            allow_blank: true
  validates :limite_total,
            numericality: { greater_than_or_equal_to: 0 },
            allow_blank: true

  validate :fechamento_e_vencimento_diferentes

  private

  def fechamento_e_vencimento_diferentes
    if fechamento_dia.present? && vencimento_dia.present? && fechamento_dia == vencimento_dia
      errors.add(:vencimento_dia, I18n.t("errors.messages.close_equal_due"))
    end
  end

  def normalize_fields
    self.apelido   = apelido&.upcase&.strip
    self.emissor   = emissor&.upcase&.strip
    self.bandeira  = bandeira&.upcase&.strip
    self.timezone  = timezone&.upcase&.strip
    self.final_cartao = final_cartao&.gsub(/\D/, "")
    self.limite_total = limite_total.to_s.gsub(",", ".") if limite_total.present?
  end
end
