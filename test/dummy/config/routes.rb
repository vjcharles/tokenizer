Rails.application.routes.draw do

  get "simulate/tokenized_thing"

  mount Tokenizer::Engine => "/tokenizer"
end
