class CreateVwFaturaItens < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      CREATE OR REPLACE VIEW public.vw_fatura_itens AS
      SELECT
          f.id AS fatura_id,
          f.cartao_id,
          f.competencia,
          f.data_fechamento,
          f.data_vencimento,
          p.id AS parcela_id,
          d.id AS despesa_id,
          pe.id AS pessoa_id,
          pe.nome AS pessoa_nome,
          d.descricao AS despesa_descricao,
          p.numero_parcela,
          p.total_parcelas,
          p.valor_parcela,
          s.situacao_pagamento
      FROM public.faturas f
      JOIN public.despesas_parcelas p ON p.fatura_id = f.id
      JOIN public.despesas d ON d.id = p.despesa_id
      JOIN public.pessoas pe ON pe.id = d.pessoa_id
      LEFT JOIN public.vw_parcelas_status s ON s.id = p.id
      ORDER BY f.cartao_id, f.competencia, p.id;
    SQL
  end

  def down
    execute "DROP VIEW IF EXISTS public.vw_fatura_itens;"
  end
end
