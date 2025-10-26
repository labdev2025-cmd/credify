class CreateVwParcelasStatus < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      CREATE OR REPLACE VIEW public.vw_parcelas_status AS
      SELECT
          dp.id,
          d.pessoa_id,
          d.cartao_id,
          dp.despesa_id,
          dp.numero_parcela,
          dp.total_parcelas,
          dp.competencia,
          dp.valor_parcela,
          COALESCE(alc.total_alocado, 0) AS valor_pago,
          (dp.valor_parcela - COALESCE(alc.total_alocado, 0)) AS valor_em_aberto,
          CASE
              WHEN COALESCE(alc.total_alocado, 0) = 0 THEN 'em_aberto'
              WHEN COALESCE(alc.total_alocado, 0) < dp.valor_parcela THEN 'parcialmente_quitada'
              ELSE 'quitada'
          END AS situacao_pagamento,
          dp.fatura_id,
          dp.status_fatura
      FROM public.despesas_parcelas dp
      JOIN public.despesas d ON d.id = dp.despesa_id
      LEFT JOIN (
          SELECT despesa_parcela_id, SUM(valor_alocado) AS total_alocado
          FROM public.alocacoes_pagamentos
          GROUP BY despesa_parcela_id
      ) alc ON alc.despesa_parcela_id = dp.id;
    SQL
  end

  def down
    execute "DROP VIEW IF EXISTS public.vw_parcelas_status;"
  end
end
