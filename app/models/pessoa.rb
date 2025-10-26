class Pessoa < ApplicationRecord
  has_many :despesas, dependent: :restrict_with_error
  has_many :despesas_fixas, dependent: :restrict_with_error
  has_many :receitas, dependent: :restrict_with_error

  before_validation :normalize_fields

  validates :nome, presence: true
  validates :documento, uniqueness: true, allow_nil: true
  validates :documento, format: { with: /\A\d+\z/, message: I18n.t("errors.messages.only_numbers") }, allow_blank: true
  validate :documento_deve_ser_cpf_ou_cnpj, if: -> { documento.present? }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :telefone, format: { with: /\A\d+\z/, message: I18n.t("errors.messages.only_numbers") }, allow_blank: true
  validates :ativo, inclusion: { in: [true, false] }

  scope :ativas, -> { where(ativo: true) }

  private

  def normalize_fields
    self.nome      = nome&.upcase&.strip
    self.apelido   = apelido&.upcase&.strip
    self.email     = email&.upcase&.strip
    self.documento = documento&.gsub(/\D/, "")
    self.telefone  = telefone&.gsub(/\D/, "")
  end

  def documento_deve_ser_cpf_ou_cnpj
    unless CpfCnpjValidators.check_cpf_cnpj(documento)
      errors.add(:documento, I18n.t("errors.messages.invalid_document"))
    end
  end
end
