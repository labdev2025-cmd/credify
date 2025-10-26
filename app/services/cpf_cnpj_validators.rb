class CpfCnpjValidators
  # Expressão regular para extrair apenas dígitos de uma string.
  ONLY_DIGITS_REGEX = /\d/

  # CPFs e CNPJs inválidos conhecidos (todos os dígitos iguais).
  INVALID_CPF_SEQUENCES = %w[00000000000 11111111111 22222222222 33333333333 44444444444 55555555555 66666666666 77777777777 88888888888 99999999999].freeze
  INVALID_CNPJ_SEQUENCES = %w[00000000000000 11111111111111 22222222222222 33333333333333 44444444444444 55555555555555 66666666666666 77777777777777 88888888888888 99999999999999].freeze

  # Pesos usados no cálculo dos dígitos verificadores.
  CPF_WEIGHTS_1 = [ 10, 9, 8, 7, 6, 5, 4, 3, 2 ].freeze
  CPF_WEIGHTS_2 = [ 11, 10, 9, 8, 7, 6, 5, 4, 3, 2 ].freeze
  CNPJ_WEIGHTS_1 = [ 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2 ].freeze
  CNPJ_WEIGHTS_2 = [ 6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2 ].freeze

  # Valida um CPF.
  def self.check_cpf(cpf)
    # 1. Limpa a string, deixando apenas os dígitos.
    numbers = clean_document(cpf)
    return false unless numbers.length == 11 && !INVALID_CPF_SEQUENCES.include?(numbers)

    # 2. Calcula os dígitos verificadores esperados.
    digit1 = calculate_digit(numbers[0..8], CPF_WEIGHTS_1)
    digit2 = calculate_digit(numbers[0..9], CPF_WEIGHTS_2)

    # 3. Compara com os dígitos originais.
    "#{digit1}#{digit2}" == numbers[9..10]
  end

  # Valida um CNPJ.
  def self.check_cnpj(cnpj)
    # 1. Limpa a string, deixando apenas os dígitos.
    numbers = clean_document(cnpj)
    return false unless numbers.length == 14 && !INVALID_CNPJ_SEQUENCES.include?(numbers)

    # 2. Calcula os dígitos verificadores esperados.
    digit1 = calculate_digit(numbers[0..11], CNPJ_WEIGHTS_1)
    digit2 = calculate_digit(numbers[0..12], CNPJ_WEIGHTS_2)

    # 3. Compara com os dígitos originais.
    "#{digit1}#{digit2}" == numbers[12..13]
  end

  # Valida um documento como CPF ou CNPJ.
  def self.check_cpf_cnpj(cpf_cnpj)
    numbers = clean_document(cpf_cnpj)
    case numbers.length
    when 11 then check_cpf(numbers)
    when 14 then check_cnpj(numbers)
    else false
    end
  end

  # Métodos privados auxiliares.
  private

  # Remove caracteres não numéricos de uma string.
  def self.clean_document(doc)
    (doc || "").scan(ONLY_DIGITS_REGEX).join
  end

  # Calcula um dígito verificador com base nos números e pesos fornecidos.
  def self.calculate_digit(numbers, weights)
    # Converte os números (string) para um array de inteiros.
    int_numbers = numbers.chars.map(&:to_i)

    # Calcula a soma ponderada.
    sum = int_numbers.zip(weights).map { |n, w| n * w }.sum

    # Calcula o resto da divisão por 11.
    remainder = sum % 11

    # Define o dígito com base no resto.
    remainder < 2 ? 0 : 11 - remainder
  end
end
