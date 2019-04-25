# frozen_string_literal: true

# Repositories Migration
class CreateRepositories < ActiveRecord::Migration[5.2]
  def change
    create_table :repositories do |t|
      t.integer :language,         null: false, limit: 1
      t.string :name,              null: false, limit: 255
      t.string :full_name,         null: false, limit: 255
      t.text :description,         null: true,  limit: 2000
      t.text :url,                 null: false
      t.string :owner_login,       null: false, limit: 255
      t.text :owner_avatar_url,    null: true
      t.integer :forks,            null: false, limit: 5
      t.integer :open_issues,      null: false, limit: 5
      t.integer :stargazers_count, null: false, limit: 5
      t.timestamps
    end
  end
end
