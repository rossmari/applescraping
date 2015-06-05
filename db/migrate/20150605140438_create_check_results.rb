class CreateCheckResults < ActiveRecord::Migration
  def change
    create_table :check_results do |t|
      t.string :imei
      t.boolean :status
      t.date :e_date

      t.timestamps null: false
    end
  end
end
