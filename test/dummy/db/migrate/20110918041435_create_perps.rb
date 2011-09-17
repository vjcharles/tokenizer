class CreatePerps < ActiveRecord::Migration
  def change
    create_table :perps do |t|
      t.string :message

      t.timestamps
    end
  end
end

