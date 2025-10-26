class CreateReceitas < ActiveRecord::Migration[8.1]
  def change
    create_table :receitas do |t|
      t.references :pessoa,    null: false, foreign_key: { on_update: :cascade, on_delete: :restrict }
      t.references :categoria,              foreign_key: { on_update: :cascade, on_delete: :nullify }

      t.text    :descricao,        null: false           # ex: "PGTO. pix", "Depósito"
      t.date    :data_recebimento, null: false
      t.decimal :valor,            precision: 14, scale: 2, null: false   # equivalente ao domínio money_brl
      t.text    :meio_pagamento    # pix|dinheiro|transferencia|boleto|outro
      t.text    :observacao

      t.timestamps default: -> { "now()" }
    end

    # Índices para performance
    add_index :receitas, :pessoa_id, name: "idx_receitas_pessoa"
    add_index :receitas, :data_recebimento, name: "idx_receitas_data"
  end
end
