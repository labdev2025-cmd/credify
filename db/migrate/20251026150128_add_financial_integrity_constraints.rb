class AddFinancialIntegrityConstraints < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      -- Garantir valores positivos em campos monetários principais
      ALTER TABLE public.despesas
        ADD CONSTRAINT ck_despesas_valor_pos CHECK (valor_total > 0);

      ALTER TABLE public.despesas_parcelas
        ADD CONSTRAINT ck_parcela_valor_pos CHECK (valor_parcela > 0);

      ALTER TABLE public.receitas
        ADD CONSTRAINT ck_receitas_valor_pos CHECK (valor > 0);
    SQL
  end

  def down
    execute <<~SQL
      ALTER TABLE public.despesas DROP CONSTRAINT IF EXISTS ck_despesas_valor_pos;
      ALTER TABLE public.despesas_parcelas DROP CONSTRAINT IF EXISTS ck_parcela_valor_pos;
      ALTER TABLE public.receitas DROP CONSTRAINT IF EXISTS ck_receitas_valor_pos;
    SQL
  end
end
