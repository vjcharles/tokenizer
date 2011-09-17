class CreateTokenizerTokenizedThings < ActiveRecord::Migration
  def change
    create_table :tokenizer_tokenized_things do |t|
      t.string :class_name
      t.string :token, :unique => true
      t.text :parameters
      t.string :redirect_url_success
      t.string :redirect_url_failure
      t.integer :lifespan #in seconds, from created_at value

      t.timestamps

    end
    add_index :tokenizer_tokenized_things, :token
    add_index :tokenizer_tokenized_things, :lifespan
    add_index :tokenizer_tokenized_things, :class_name
  end
end
