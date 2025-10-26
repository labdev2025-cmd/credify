# frozen_string_literal: true

class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def tratar_msg_api_veiculo(msg)
    if msg["subErrors"].present?
      msg["subErrors"].map { |j| j["message"] }.join(" ")
    else
      msg["message"]
    end
  end
end
