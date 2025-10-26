# app/helpers/cartoes_helper.rb
module CartoesHelper
  def formatar_valor(valor)
    number_to_currency(valor, unit: "R$", separator: ",", delimiter: ".", format: "%u %n")
  end
end
