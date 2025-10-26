require "test_helper"

class CartoesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cartao = cartoes(:one)
  end

  test "should get index" do
    get cartoes_url
    assert_response :success
  end

  test "should get new" do
    get new_cartao_url
    assert_response :success
  end

  test "should create cartao" do
    assert_difference("Cartao.count") do
      post cartoes_url, params: { cartao: { apelido: @cartao.apelido, ativo: @cartao.ativo, bandeira: @cartao.bandeira, emissor: @cartao.emissor, fechamento_dia: @cartao.fechamento_dia, final_cartao: @cartao.final_cartao, limite_total: @cartao.limite_total, timezone: @cartao.timezone, vencimento_dia: @cartao.vencimento_dia } }
    end

    assert_redirected_to cartao_url(Cartao.last)
  end

  test "should show cartao" do
    get cartao_url(@cartao)
    assert_response :success
  end

  test "should get edit" do
    get edit_cartao_url(@cartao)
    assert_response :success
  end

  test "should update cartao" do
    patch cartao_url(@cartao), params: { cartao: { apelido: @cartao.apelido, ativo: @cartao.ativo, bandeira: @cartao.bandeira, emissor: @cartao.emissor, fechamento_dia: @cartao.fechamento_dia, final_cartao: @cartao.final_cartao, limite_total: @cartao.limite_total, timezone: @cartao.timezone, vencimento_dia: @cartao.vencimento_dia } }
    assert_redirected_to cartao_url(@cartao)
  end

  test "should destroy cartao" do
    assert_difference("Cartao.count", -1) do
      delete cartao_url(@cartao)
    end

    assert_redirected_to cartoes_url
  end
end
