class CreateVwSaldosPessoa < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      CREATE OR REPLACE VIEW public.vw_saldos_pessoa AS
      WITH debitos AS (
          SELECT
              d.pessoa_id,
              SUM(
                  dp.valor_parcela
                  - COALESCE(
                      (SELECT SUM(ap.valor_alocado)
                       FROM public.alocacoes_pagamentos ap
                       WHERE ap.despesa_parcela_id = dp.id), 0)
              ) AS total_em_aberto
          FROM public.despesas_parcelas dp
          JOIN public.despesas d ON d.id = dp.despesa_id
          WHERE dp.status_fatura <> 'estornada'
          GROUP BY d.pessoa_id
      ),
      creditos AS (
          -- Créditos "livres" = receitas - total alocado nessas receitas
          SELECT
              r.pessoa_id,
              SUM(r.valor - COALESCE(alc.total_alocado, 0)) AS creditos_livres
          FROM public.receitas r
          LEFT JOIN (
              SELECT receita_id, SUM(valor_alocado) AS total_alocado
              FROM public.alocacoes_pagamentos
              GROUP BY receita_id
          ) alc ON alc.receita_id = r.id
          GROUP BY r.pessoa_id
      )
      SELECT
          p.id AS pessoa_id,
          p.nome,
          COALESCE(d.total_em_aberto, 0) AS total_em_aberto,
          COALESCE(c.creditos_livres, 0) AS creditos_livres,
          (COALESCE(d.total_em_aberto, 0) - COALESCE(c.creditos_livres, 0)) AS saldo_a_receber
      FROM public.pessoas p
      LEFT JOIN debitos d ON d.pessoa_id = p.id
      LEFT JOIN creditos c ON c.pessoa_id = p.id
      ORDER BY p.nome;
    SQL
  end

  def down
    execute "DROP VIEW IF EXISTS public.vw_saldos_pessoa;"
  end
end
