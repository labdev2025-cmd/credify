json.extract! pessoa, :id, :nome, :apelido, :documento, :email, :telefone, :ativo, :created_at, :updated_at
json.url pessoa_url(pessoa, format: :json)
