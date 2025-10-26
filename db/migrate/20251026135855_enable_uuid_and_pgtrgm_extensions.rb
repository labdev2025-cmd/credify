class EnableUuidAndPgtrgmExtensions < ActiveRecord::Migration[8.1]
  def change
    enable_extension 'uuid-ossp'
    enable_extension 'pg_trgm'
  end
end
