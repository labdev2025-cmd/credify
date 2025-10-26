module FlashHelper
  def flash_messages
    safe_join(
      flash.map do |type, message|
        next if message.blank?

        type = normalize_flash_type(type)
        Array(message).map { |msg| flash_container(type, msg) }
      end.flatten.compact
    )
  end

  private

  def normalize_flash_type(type)
    case type.to_sym
    when :notice then :success
    when :alert then :warning
    when :danger then :error
    else type.to_sym
    end
  end

  def flash_container(type, message)
    content_tag(:div, class: "ui #{type} message") do
      concat(content_tag(:i, "", class: "close icon"))
      concat(sanitize(message, tags: %w[a b i u strong em], attributes: %w[href title]))
    end
  end
end
