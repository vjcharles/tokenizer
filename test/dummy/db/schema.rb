# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110918041435) do

  create_table "derps", :force => true do |t|
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "perps", :force => true do |t|
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tokenizer_tokenized_things", :force => true do |t|
    t.string   "class_name"
    t.string   "token"
    t.text     "parameters"
    t.string   "redirect_url_success"
    t.string   "redirect_url_failure"
    t.datetime "lifespan"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tokenizer_tokenized_things", ["lifespan"], :name => "index_tokenizer_tokenized_things_on_lifespan"
  add_index "tokenizer_tokenized_things", ["token"], :name => "index_tokenizer_tokenized_things_on_token"

end
