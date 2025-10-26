class CreatePessoas < ActiveRecord::Migration[8.1]
  def change
    create_table :pessoas do |t|
      t.text :nome, null: false
      t.text :apelido
      t.text :documento
      t.text :email
      t.text :telefone
      t.boolean :ativo, null: false, default: true

      t.timestamps
    end

    add_index :pessoas, :nome, using: :gin, opclass: :gin_trgm_ops, name: "idx_pessoas_nome_trgm"
    add_index :pessoas, :documento, unique: true, where: "documento IS NOT NULL", name: "uq_pessoas_documento"
  end
end
