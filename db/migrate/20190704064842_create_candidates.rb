# frozen_string_literal: true

class CreateCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :candidates do |t|
      t.date :date_of_registration
      t.date :date_of_closure
      t.text :address
      t.integer :age
      t.string :branch
      t.string :contact_number
      t.string :email
      t.string :experience
      t.string :gender
      t.string :name
      t.string :qualification
      t.string :registration_number
      t.integer :remarks
      t.string :specialization
      t.string :source_of_registration
      t.string :state
      t.string :status
      t.string :zone

      t.timestamps
    end
    add_index :candidates, :contact_number, unique: true
    add_index :candidates, :email, unique: true
    add_index :candidates, :registration_number, unique: true
  end
end
