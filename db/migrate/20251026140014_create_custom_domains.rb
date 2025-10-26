class CreateCustomDomains < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      DO
      $$
      BEGIN
          IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'dia_mes') THEN
              CREATE DOMAIN dia_mes AS smallint CHECK (VALUE BETWEEN 1 AND 31);
          END IF;
      END
      $$;

      DO
      $$
      BEGIN
          IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'money_brl') THEN
              CREATE DOMAIN money_brl AS numeric(14, 2) CHECK (VALUE >= 0);
          END IF;
      END
      $$;
    SQL
  end

  def down
    execute <<~SQL
      DROP DOMAIN IF EXISTS dia_mes;
      DROP DOMAIN IF EXISTS money_brl;
    SQL
  end
end
