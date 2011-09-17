Tokenizer::Engine.routes.draw do
  root :to => 'tokenized_things#index'
  match 'token/:token' => 'tokenized_things#token', :as => :token
end
