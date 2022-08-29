class CreateElectionAudits < ActiveRecord::Migration[6.1]
  def change
    create_table :election_audits do |t|
      t.integer :election_id
      t.integer :user_id
      t.string :updated_field
      t.string :before_value
      t.string :after_value
      t.references :auditable, polymorphic: true

      t.timestamps
    end
    add_index :election_audits, :election_id
  end
end
