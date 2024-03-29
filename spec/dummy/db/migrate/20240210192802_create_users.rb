# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :name

      t.boolean :is_active, default: true, null: false
      t.timestamps
    end
  end
end
