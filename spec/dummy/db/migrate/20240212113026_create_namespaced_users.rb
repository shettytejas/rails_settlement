# frozen_string_literal: true

class CreateNamespacedUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :namespaceds do |t|
      t.string :type, null: false, index: true
      t.string :username
      t.string :name
      t.boolean :is_admin, default: false, null: false
      t.timestamps
    end
  end
end
