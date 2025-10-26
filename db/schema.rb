# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2025_10_26_150128) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pg_trgm"
  enable_extension "uuid-ossp"

  create_table "alocacoes_pagamentos", force: :cascade do |t|
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.bigint "despesa_parcela_id", null: false
    t.bigint "receita_id", null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.decimal "valor_alocado", precision: 14, scale: 2, null: false
    t.index ["despesa_parcela_id"], name: "idx_alocacoes_parcela"
    t.index ["despesa_parcela_id"], name: "index_alocacoes_pagamentos_on_despesa_parcela_id"
    t.index ["receita_id", "despesa_parcela_id"], name: "uq_alocacao_unica", unique: true
    t.index ["receita_id"], name: "idx_alocacoes_receita"
    t.index ["receita_id"], name: "index_alocacoes_pagamentos_on_receita_id"
    t.check_constraint "valor_alocado > 0::numeric", name: "ck_valor_alocado_pos"
  end

  create_table "cartoes", force: :cascade do |t|
    t.text "apelido", null: false
    t.boolean "ativo", default: true, null: false
    t.text "bandeira"
    t.datetime "created_at", null: false
    t.text "emissor"
    t.integer "fechamento_dia", null: false
    t.string "final_cartao", limit: 4
    t.decimal "limite_total", precision: 14, scale: 2
    t.text "timezone", default: "America/Fortaleza", null: false
    t.datetime "updated_at", null: false
    t.integer "vencimento_dia", null: false
    t.index ["apelido"], name: "uq_cartoes_apelido", unique: true
    t.check_constraint "fechamento_dia <> vencimento_dia", name: "ck_cartoes_dias_diff"
  end

  create_table "categorias", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "nome", null: false
    t.text "tipo", null: false
    t.datetime "updated_at", null: false
    t.index ["nome", "tipo"], name: "uq_categorias_nome_tipo", unique: true
    t.check_constraint "tipo = ANY (ARRAY['despesa'::text, 'receita'::text])", name: "ck_categorias_tipo"
  end

  create_table "despesas", force: :cascade do |t|
    t.bigint "cartao_id", null: false
    t.bigint "categoria_id"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.date "data_compra", null: false
    t.text "descricao", null: false
    t.integer "numero_parcelas", default: 1, null: false
    t.text "observacao"
    t.bigint "pessoa_id", null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.decimal "valor_total", precision: 14, scale: 2, null: false
    t.index ["cartao_id"], name: "idx_despesas_cartao"
    t.index ["cartao_id"], name: "index_despesas_on_cartao_id"
    t.index ["categoria_id"], name: "index_despesas_on_categoria_id"
    t.index ["data_compra"], name: "idx_despesas_data_compra"
    t.index ["pessoa_id", "id"], name: "idx_despesas_pessoa_id"
    t.index ["pessoa_id"], name: "idx_despesas_pessoa"
    t.index ["pessoa_id"], name: "index_despesas_on_pessoa_id"
    t.check_constraint "numero_parcelas >= 1", name: "ck_despesas_num_parc"
    t.check_constraint "valor_total > 0::numeric", name: "ck_despesas_valor_pos"
  end

  create_table "despesas_fixas", force: :cascade do |t|
    t.boolean "ativa", default: true, null: false
    t.bigint "cartao_id", null: false
    t.bigint "categoria_id"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.text "descricao", null: false
    t.integer "dia_lancamento", null: false
    t.date "fim_em"
    t.date "inicio_em", null: false
    t.text "observacao"
    t.bigint "pessoa_id", null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.decimal "valor_mensal", precision: 14, scale: 2, null: false
    t.index ["ativa"], name: "idx_fixas_ativa"
    t.index ["cartao_id"], name: "idx_fixas_cartao"
    t.index ["cartao_id"], name: "index_despesas_fixas_on_cartao_id"
    t.index ["categoria_id"], name: "index_despesas_fixas_on_categoria_id"
    t.index ["pessoa_id"], name: "idx_fixas_pessoa"
    t.index ["pessoa_id"], name: "index_despesas_fixas_on_pessoa_id"
    t.check_constraint "fim_em IS NULL OR fim_em >= inicio_em", name: "ck_fixas_periodo"
  end

  create_table "despesas_parcelas", force: :cascade do |t|
    t.date "competencia", null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.bigint "despesa_id", null: false
    t.bigint "fatura_id"
    t.integer "numero_parcela", null: false
    t.text "status_fatura", default: "a_faturar", null: false
    t.integer "total_parcelas", null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.decimal "valor_parcela", precision: 14, scale: 2, null: false
    t.index ["competencia"], name: "idx_parcelas_competencia"
    t.index ["despesa_id", "competencia"], name: "idx_parcelas_despesa_competencia"
    t.index ["despesa_id", "numero_parcela"], name: "uq_parcela_unica", unique: true
    t.index ["despesa_id"], name: "idx_parcelas_despesa"
    t.index ["despesa_id"], name: "index_despesas_parcelas_on_despesa_id"
    t.index ["fatura_id"], name: "idx_parcelas_fatura"
    t.index ["fatura_id"], name: "index_despesas_parcelas_on_fatura_id"
    t.check_constraint "numero_parcela >= 1", name: "ck_parcela_numero"
    t.check_constraint "status_fatura = ANY (ARRAY['a_faturar'::text, 'faturada'::text, 'paga'::text, 'estornada'::text])", name: "ck_status_fatura"
    t.check_constraint "total_parcelas >= 1 AND total_parcelas >= numero_parcela", name: "ck_parcela_total"
    t.check_constraint "valor_parcela > 0::numeric", name: "ck_parcela_valor_pos"
  end

  create_table "faturas", force: :cascade do |t|
    t.bigint "cartao_id", null: false
    t.date "competencia", null: false
    t.datetime "created_at", null: false
    t.date "data_fechamento", null: false
    t.date "data_vencimento", null: false
    t.text "observacao"
    t.date "pago_em"
    t.text "status", default: "aberta", null: false
    t.datetime "updated_at", null: false
    t.decimal "valor_fechado", precision: 14, scale: 2
    t.index ["cartao_id", "competencia"], name: "idx_faturas_cartao_comp"
    t.index ["cartao_id", "competencia"], name: "uq_faturas_cartao_comp", unique: true
    t.index ["cartao_id"], name: "index_faturas_on_cartao_id"
    t.index ["status"], name: "idx_faturas_status"
    t.check_constraint "status = ANY (ARRAY['aberta'::text, 'fechada'::text, 'paga'::text, 'cancelada'::text])", name: "ck_faturas_status"
  end

  create_table "pessoas", force: :cascade do |t|
    t.text "apelido"
    t.boolean "ativo", default: true, null: false
    t.datetime "created_at", null: false
    t.text "documento"
    t.text "email"
    t.text "nome", null: false
    t.text "telefone"
    t.datetime "updated_at", null: false
    t.index ["documento"], name: "uq_pessoas_documento", unique: true, where: "(documento IS NOT NULL)"
    t.index ["nome"], name: "idx_pessoas_nome_trgm", opclass: :gin_trgm_ops, using: :gin
  end

  create_table "receitas", force: :cascade do |t|
    t.bigint "categoria_id"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.date "data_recebimento", null: false
    t.text "descricao", null: false
    t.text "meio_pagamento"
    t.text "observacao"
    t.bigint "pessoa_id", null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.decimal "valor", precision: 14, scale: 2, null: false
    t.index ["categoria_id"], name: "index_receitas_on_categoria_id"
    t.index ["data_recebimento"], name: "idx_receitas_data"
    t.index ["pessoa_id"], name: "idx_receitas_pessoa"
    t.index ["pessoa_id"], name: "index_receitas_on_pessoa_id"
    t.check_constraint "valor > 0::numeric", name: "ck_receitas_valor_pos"
  end

  add_foreign_key "alocacoes_pagamentos", "despesas_parcelas", column: "despesa_parcela_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "alocacoes_pagamentos", "receitas", on_update: :cascade, on_delete: :cascade
  add_foreign_key "despesas", "cartoes", on_update: :cascade, on_delete: :restrict
  add_foreign_key "despesas", "categorias", on_update: :cascade, on_delete: :nullify
  add_foreign_key "despesas", "pessoas", on_update: :cascade, on_delete: :restrict
  add_foreign_key "despesas_fixas", "cartoes", on_update: :cascade, on_delete: :restrict
  add_foreign_key "despesas_fixas", "categorias", on_update: :cascade, on_delete: :nullify
  add_foreign_key "despesas_fixas", "pessoas", on_update: :cascade, on_delete: :restrict
  add_foreign_key "despesas_parcelas", "despesas", on_update: :cascade, on_delete: :cascade
  add_foreign_key "despesas_parcelas", "faturas", on_update: :cascade, on_delete: :nullify
  add_foreign_key "faturas", "cartoes", on_update: :cascade, on_delete: :restrict
  add_foreign_key "receitas", "categorias", on_update: :cascade, on_delete: :nullify
  add_foreign_key "receitas", "pessoas", on_update: :cascade, on_delete: :restrict
end
