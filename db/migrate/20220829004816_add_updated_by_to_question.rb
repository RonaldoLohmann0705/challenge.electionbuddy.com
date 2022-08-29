class AddUpdatedByToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :updated_by, :integer
  end
end
