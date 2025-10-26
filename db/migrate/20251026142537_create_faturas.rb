class CreateFaturas < ActiveRecord::Migration[8.1]
  def change
    create_table :faturas do |t|
      t.references :cartao, null: false, foreign_key: { on_update: :cascade, on_delete: :restrict }
      t.date    :competencia,     null: false    # 1º dia do mês representando a fatura
      t.date    :data_fechamento, null: false
      t.date    :data_vencimento, null: false
      t.text    :status,          null: false, default: "aberta" # aberta|fechada|paga|cancelada
      t.decimal :valor_fechado, precision: 14, scale: 2          # equivalente a money_brl
      t.date    :pago_em
      t.text    :observacao

      t.timestamps default: -> { "now()" }
    end

    # Constraint de status
    execute <<~SQL
      ALTER TABLE faturas
      ADD CONSTRAINT ck_faturas_status
      CHECK (status IN ('aberta', 'fechada', 'paga', 'cancelada'));
    SQL

    # Constraint de unicidade (cartão + competência)
    add_index :faturas, [ :cartao_id, :competencia ], unique: true, name: "uq_faturas_cartao_comp"

    # Índices auxiliares
    add_index :faturas, [ :cartao_id, :competencia ], name: "idx_faturas_cartao_comp"
    add_index :faturas, :status, name: "idx_faturas_status"
  end
end
