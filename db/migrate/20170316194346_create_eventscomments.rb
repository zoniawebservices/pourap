class CreateEventscomments < ActiveRecord::Migration[5.0]
  def change
    create_table :eventscomments do |t|
      t.string :name
      t.text :body
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
