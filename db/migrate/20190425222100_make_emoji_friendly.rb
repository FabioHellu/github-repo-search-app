# frozen_string_literal: true

# Makes Emoji Friendly
class MakeEmojiFriendly < ActiveRecord::Migration[5.2]
  def change
    alter_database_and_tables_charsets 'utf8mb4', 'utf8mb4_bin'
  end

  private

  def alter_database_and_tables_charsets(charset = default_charset, collation = default_collation)
    msg = 'Migration error: Unsupported database for migration to UTF-8 support'
    adapter = connection.adapter_name

    raise ActiveRecord::IrreversibleMigration, msg unless adapter == 'Mysql2'

    execute "ALTER DATABASE #{connection.current_database} CHARACTER SET #{charset} COLLATE #{collation}"

    connection.tables.each do |table|
      execute "ALTER TABLE #{table} CONVERT TO CHARACTER SET #{charset} COLLATE #{collation}"
    end
  end

  def default_charset
    if connection.adapter_name == 'Mysql2'
      execute("show variables like 'character_set_server'").fetch_hash['Value']
    end
  end

  def default_collation
    if connection.adapter_name == 'Mysql2'
      execute("show variables like 'collation_server'").fetch_hash['Value']
    end
  end

  def connection
    ActiveRecord::Base.connection
  end
end
