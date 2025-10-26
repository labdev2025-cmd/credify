class CreateDespesas < ActiveRecord::Migration[8.1]
  def change
    create_table :despesas do |t|
      t.references :pessoa,    null: false, foreign_key: { on_update: :cascade, on_delete: :restrict }
      t.references :cartao,    null: false, foreign_key: { on_update: :cascade, on_delete: :restrict }
      t.references :categoria,              foreign_key: { on_update: :cascade, on_delete: :nullify }

      t.text    :descricao,       null: false
      t.date    :data_compra,     null: false
      t.decimal :valor_total,     precision: 14, scale: 2, null: false  # equivalente ao domínio money_brl
      t.integer :numero_parcelas, null: false, default: 1
      t.text    :observacao

      t.timestamps default: -> { "now()" }
    end

    # Constraint: número de parcelas >= 1
    execute <<~SQL
      ALTER TABLE despesas
      ADD CONSTRAINT ck_despesas_num_parc
      CHECK (numero_parcelas >= 1);
    SQL

    # Índices otimizados para consultas
    add_index :despesas, :pessoa_id, name: "idx_despesas_pessoa"
    add_index :despesas, :cartao_id, name: "idx_despesas_cartao"
    add_index :despesas, :data_compra, name: "idx_despesas_data_compra"
  end
end
