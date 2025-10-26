module Constants
  module VEICULO
    ACCESS_KEY      = "e23e5c1c74128c1dd5369e113980e6db301dad70"
    HOST            = Rails.env.production? ? "http://172.25.136.47/veiculows" : "http://172.25.136.47/veiculows_dev"
    LOGAR_CERT_ICP  = "#{HOST}/icpBrasil/api/autenticar/logarCertificado"
  end

  module CREDENCIA
    ACCESS_KEY                      = "e23e5c1c74128c1dd5369e113980e6db301dad70"
    HOST                            = Rails.env.production? ? "http://172.25.136.159/credenciaws" : "http://172.25.136.77/credenciaws_dev"
    CONSULTA_CREDENCIADOS           = "#{HOST}/api/v1/credencia/credenciados"
    CONSULTAR_EDITAL_CREDENCIAMENTO = "#{HOST}/api/v1/credencia/edital-credenciamentos"
    module EDITAL_CREDENCIAMENTO
      # TODO precisa acrescentar o edital credenciamento de produção
      DESMONTADORA  = Rails.env.production? ? 0 : 70
      RECICLADORA   = Rails.env.production? ? 0 : 71
      GRAFICA       = Rails.env.production? ? 0 : 72
    end
  end
end
