class AddUniquenessIndexToSlackThread < ActiveRecord::Migration[6.0]
  def change
    add_column :slack_threads, :created_on, :date
    add_index :slack_threads, [:thread_ts, :created_on], unique: true
  end
end
