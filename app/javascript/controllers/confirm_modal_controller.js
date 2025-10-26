import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static values = {
        message: String
    }

    connect() {
        // Garante que o modal existe no body
        if (!document.getElementById('confirm-modal')) {
            document.body.insertAdjacentHTML('beforeend', `
        <div id="confirm-modal" class="ui small modal">
          <div class="header">Confirmação</div>
          <div class="content">
            <p id="confirm-modal-message"></p>
          </div>
          <div class="actions">
            <div class="ui negative button">Cancelar</div>
            <div class="ui positive button">Confirmar</div>
          </div>
        </div>
      `)

            // Adiciona eventos nos botões
            $('#confirm-modal .negative.button').on('click', function() {
                $('#confirm-modal').modal('hide')
            })
        }
    }

    confirm(event) {
        event.preventDefault()
        const form = this.element.closest('form')

        $('#confirm-modal-message').text(this.messageValue)
        $('#confirm-modal').modal({
            onApprove: function() {
                form.submit()
            }
        }).modal('show')
    }
}
