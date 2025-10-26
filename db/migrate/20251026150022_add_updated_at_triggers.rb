class AddUpdatedAtTriggers < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      -- Função que atualiza o updated_at
      CREATE OR REPLACE FUNCTION public.set_updated_at()
      RETURNS trigger
      LANGUAGE plpgsql AS
      $$
      BEGIN
          NEW.updated_at := now();
          RETURN NEW;
      END
      $$;

      -- Criar triggers automaticamente para todas as tabelas relevantes
      DO
      $$
      DECLARE
          r record;
      BEGIN
          FOR r IN
              SELECT relname
              FROM pg_class c
              JOIN pg_namespace n ON n.oid = c.relnamespace
              WHERE n.nspname = 'public'
                AND c.relkind = 'r'
                AND relname IN
                    ('pessoas', 'cartoes', 'categorias', 'faturas',
                     'despesas', 'despesas_parcelas', 'despesas_fixas',
                     'receitas', 'alocacoes_pagamentos')
          LOOP
              EXECUTE format('DROP TRIGGER IF EXISTS set_updated_at_%I ON public.%I;', r.relname, r.relname);
              EXECUTE format(
                  'CREATE TRIGGER set_updated_at_%I
                   BEFORE UPDATE ON public.%I
                   FOR EACH ROW
                   EXECUTE FUNCTION public.set_updated_at();',
                  r.relname, r.relname);
          END LOOP;
      END
      $$;
    SQL
  end

  def down
    execute <<~SQL
      DROP FUNCTION IF EXISTS public.set_updated_at() CASCADE;
    SQL
  end
end
