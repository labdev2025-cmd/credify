class CreateDespesasFixas < ActiveRecord::Migration[8.1]
  def change
    create_table :despesas_fixas do |t|
      t.references :pessoa,    null: false, foreign_key: { on_update: :cascade, on_delete: :restrict }
      t.references :cartao,    null: false, foreign_key: { on_update: :cascade, on_delete: :restrict }
      t.references :categoria,              foreign_key: { on_update: :cascade, on_delete: :nullify }

      t.text    :descricao,     null: false
      t.decimal :valor_mensal,  precision: 14, scale: 2, null: false   # equivalente a money_brl
      t.integer :dia_lancamento, null: false                            # equivalente ao domínio dia_mes
      t.date    :inicio_em,     null: false
      t.date    :fim_em                                            # nulo = indefinido
      t.boolean :ativa,         null: false, default: true
      t.text    :observacao

      t.timestamps default: -> { "now()" }
    end

    # Constraint de integridade: fim_em >= inicio_em (ou nulo)
    execute <<~SQL
      ALTER TABLE despesas_fixas
      ADD CONSTRAINT ck_fixas_periodo
      CHECK (fim_em IS NULL OR fim_em >= inicio_em);
    SQL

    # Índices para otimização de consultas
    add_index :despesas_fixas, :pessoa_id, name: "idx_fixas_pessoa"
    add_index :despesas_fixas, :cartao_id, name: "idx_fixas_cartao"
    add_index :despesas_fixas, :ativa,     name: "idx_fixas_ativa"
  end
end
