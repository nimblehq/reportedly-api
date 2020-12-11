class CreateSlackThreads < ActiveRecord::Migration[6.0]
  def change
    create_table :slack_threads do |t|
      t.string :thread_ts

      t.timestamps
    end
  end
end
