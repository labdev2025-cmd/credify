class CreateDespesasParcelas < ActiveRecord::Migration[8.1]
  def change
    create_table :despesas_parcelas do |t|
      t.references :despesa, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.integer    :numero_parcela, null: false               # 1..N
      t.integer    :total_parcelas, null: false               # cópia de numero_parcelas
      t.decimal    :valor_parcela, precision: 14, scale: 2, null: false  # equivalente a money_brl
      t.date       :competencia, null: false                  # mês da fatura (1º dia do mês)
      t.references :fatura, foreign_key: { on_update: :cascade, on_delete: :nullify }

      t.text       :status_fatura, null: false, default: "a_faturar" # a_faturar|faturada|paga|estornada

      t.timestamps default: -> { "now()" }
    end

    # === Constraints ===
    execute <<~SQL
      ALTER TABLE despesas_parcelas
      ADD CONSTRAINT ck_parcela_numero CHECK (numero_parcela >= 1);

      ALTER TABLE despesas_parcelas
      ADD CONSTRAINT ck_parcela_total
      CHECK (total_parcelas >= 1 AND total_parcelas >= numero_parcela);

      ALTER TABLE despesas_parcelas
      ADD CONSTRAINT ck_status_fatura
      CHECK (status_fatura IN ('a_faturar', 'faturada', 'paga', 'estornada'));
    SQL

    # Unicidade da parcela dentro da despesa
    add_index :despesas_parcelas, [ :despesa_id, :numero_parcela ], unique: true, name: "uq_parcela_unica"

    # Índices adicionais
    add_index :despesas_parcelas, :despesa_id, name: "idx_parcelas_despesa"
    add_index :despesas_parcelas, :competencia, name: "idx_parcelas_competencia"
    add_index :despesas_parcelas, :fatura_id, name: "idx_parcelas_fatura"
  end
end
