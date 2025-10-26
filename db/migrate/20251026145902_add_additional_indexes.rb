class AddAdditionalIndexes < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      -- Ajuda o plano: lookup por despesa e filtro por competência
      CREATE INDEX IF NOT EXISTS idx_parcelas_despesa_competencia
        ON public.despesas_parcelas (despesa_id, competencia);

      -- Ajuda o plano: de pessoa -> ids de despesas
      CREATE INDEX IF NOT EXISTS idx_despesas_pessoa_id
        ON public.despesas (pessoa_id, id);
    SQL
  end

  def down
    execute <<~SQL
      DROP INDEX IF EXISTS public.idx_parcelas_despesa_competencia;
      DROP INDEX IF EXISTS public.idx_despesas_pessoa_id;
    SQL
  end
end
