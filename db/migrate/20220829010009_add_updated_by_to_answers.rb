class AddUpdatedByToAnswers < ActiveRecord::Migration[6.1]
  def change
    add_column :answers, :updated_by, :integer
  end
end
