class CreateAlocacoesPagamentos < ActiveRecord::Migration[8.1]
  def change
    create_table :alocacoes_pagamentos do |t|
      t.references :receita,           null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :despesa_parcela,   null: false, foreign_key: { to_table: :despesas_parcelas, on_update: :cascade, on_delete: :cascade }
      t.decimal    :valor_alocado,     precision: 14, scale: 2, null: false   # equivalente ao domínio money_brl

      t.timestamps default: -> { "now()" }
    end

    # Constraint: valor_alocado > 0
    execute <<~SQL
      ALTER TABLE alocacoes_pagamentos
      ADD CONSTRAINT ck_valor_alocado_pos
      CHECK (valor_alocado > 0);
    SQL

    # Unicidade da alocação (uma receita para uma parcela apenas uma vez)
    add_index :alocacoes_pagamentos,
              [ :receita_id, :despesa_parcela_id ],
              unique: true,
              name: "uq_alocacao_unica"

    # Índices adicionais
    add_index :alocacoes_pagamentos, :receita_id, name: "idx_alocacoes_receita"
    add_index :alocacoes_pagamentos, :despesa_parcela_id, name: "idx_alocacoes_parcela"
  end
end
