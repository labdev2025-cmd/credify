module PessoasHelper
  def formatar_documento(numero)
    return if numero.blank?

    if numero.length == 11
      numero.gsub(/(\d{3})(\d{3})(\d{3})(\d{2})/, '\\1.\\2.\\3-\\4')
    elsif numero.length == 14
      numero.gsub(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '\\1.\\2.\\3/\\4-\\5')
    else
      numero
    end
  end

  def formatar_telefone(numero)
    return if numero.blank?
    numero.gsub(/(\d{2})(\d{5})(\d{4})/, '(\\1) \\2-\\3')
  end
end
