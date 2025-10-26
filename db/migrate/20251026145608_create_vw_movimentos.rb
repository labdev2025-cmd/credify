class CreateVwMovimentos < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      CREATE OR REPLACE VIEW public.vw_movimentos AS
      WITH parcelas AS (
          SELECT
              dp.id AS movimento_id,
              d.pessoa_id,
              d.cartao_id,
              'despesa'::text AS tipo,
              d.descricao || ' ' ||
              dp.numero_parcela::text || '/' || dp.total_parcelas::text AS descricao,
              dp.competencia AS data_movimento,
              (dp.valor_parcela
                  - COALESCE((SELECT SUM(ap.valor_alocado)
                              FROM public.alocacoes_pagamentos ap
                              WHERE ap.despesa_parcela_id = dp.id), 0)
                  ) * (-1) AS valor, -- valor em aberto (negativo)
              dp.valor_parcela AS valor_original,
              COALESCE((SELECT SUM(ap.valor_alocado)
                        FROM public.alocacoes_pagamentos ap
                        WHERE ap.despesa_parcela_id = dp.id), 0) AS valor_liquidado,
              dp.fatura_id
          FROM public.despesas_parcelas dp
          JOIN public.despesas d ON d.id = dp.despesa_id
          WHERE dp.status_fatura <> 'estornada'
      ),
      receitas AS (
          SELECT
              r.id AS movimento_id,
              r.pessoa_id,
              NULL::bigint AS cartao_id,
              'receita'::text AS tipo,
              r.descricao AS descricao,
              r.data_recebimento AS data_movimento,
              r.valor AS valor, -- crédito (positivo)
              r.valor AS valor_original,
              r.valor AS valor_liquidado,
              NULL::bigint AS fatura_id
          FROM public.receitas r
      )
      SELECT * FROM parcelas
      UNION ALL
      SELECT * FROM receitas;
    SQL
  end

  def down
    execute "DROP VIEW IF EXISTS public.vw_movimentos;"
  end
end
