# Necessário para usar content_tag no initializer
include ActionView::Helpers::TagHelper

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  # Parse do campo HTML
  fragment = Nokogiri::HTML::DocumentFragment.parse(html_tag)
  element = fragment.at_css("label, input, select, textarea")

  # Classes CSS padrão
  form_field_class = "ui form field error"
  label_field_class = "field error"

  # Se quiser usar as mensagens de erro do instance, descomente abaixo:
  # error_message = Array(instance.error_message).join(", ")

  if element
    case element.name
    when "label"
      content_tag(:div, html_tag.html_safe, class: label_field_class)
    when "input", "select", "textarea"
      content_tag(:div, class: form_field_class) do
        html_tag.html_safe

        # Se quiser exibir a mensagem de erro abaixo do campo, descomente abaixo:
        # + content_tag(:div, error_message, class: "ui pointing red basic label")
      end
    else
      html_tag
    end
  else
    html_tag
  end
end
