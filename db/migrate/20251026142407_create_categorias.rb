class CreateCategorias < ActiveRecord::Migration[8.1]
  def change
    create_table :categorias do |t|
      t.text :nome, null: false
      t.text :tipo, null: false  # 'despesa' ou 'receita'

      t.timestamps default: -> { "now()" }
    end

    # Constraint que garante que tipo é 'despesa' ou 'receita'
    execute <<~SQL
      ALTER TABLE categorias
      ADD CONSTRAINT ck_categorias_tipo
      CHECK (tipo IN ('despesa', 'receita'));
    SQL

    # Índice único combinando nome e tipo
    add_index :categorias, [ :nome, :tipo ], unique: true, name: "uq_categorias_nome_tipo"
  end
end
