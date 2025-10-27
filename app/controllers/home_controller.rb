class HomeController < ApplicationController
  def index
    # Opcional: Carregue dados para exibir no dashboard
    # (Assumindo que você tenha os models Pessoa e Cartao)
    @total_pessoas = Pessoa.count
    @total_cartoes = Cartao.count
    @total_categorias = Categoria.count
  end
end
