class CreateCartoes < ActiveRecord::Migration[8.1]
  def change
    create_table :cartoes do |t|
      t.text    :apelido,        null: false            # ex: "Nubank Principal"
      t.text    :emissor                                    # banco/fintech
      t.text    :bandeira                                   # Visa/Mastercard/Amex/etc.
      t.string  :final_cartao,  limit: 4                   # últimos 4 dígitos
      t.integer :fechamento_dia, null: false               # originalmente domínio dia_mes
      t.integer :vencimento_dia, null: false               # idem
      t.decimal :limite_total, precision: 14, scale: 2     # originalmente money_brl
      t.boolean :ativo,          null: false, default: true
      t.text    :timezone,       null: false, default: "America/Fortaleza"

      t.timestamps default: -> { "now()" }
    end

    # Constraint de consistência entre dias
    execute <<~SQL
      ALTER TABLE cartoes
      ADD CONSTRAINT ck_cartoes_dias_diff
      CHECK (fechamento_dia <> vencimento_dia);
    SQL

    add_index :cartoes, :apelido, unique: true, name: "uq_cartoes_apelido"
  end
end
