# frozen_string_literal: true

class AddLinkedinToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :linkedin_handle, :string
  end
end
