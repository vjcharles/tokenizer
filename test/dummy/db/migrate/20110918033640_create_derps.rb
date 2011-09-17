class CreateDerps < ActiveRecord::Migration
  def change
    create_table :derps do |t|
      t.string :message

      t.timestamps
    end
  end
end
