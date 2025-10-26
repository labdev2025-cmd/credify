json.extract! cartao, :id, :apelido, :emissor, :bandeira, :final_cartao, :fechamento_dia, :vencimento_dia, :limite_total, :ativo, :timezone, :created_at, :updated_at
json.url cartao_url(cartao, format: :json)
