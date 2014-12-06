Tokenizer::Engine.routes.draw do
  root :to => 'tokenized_things#index'
  get 'token/:token', to: 'tokenized_things#token', :as => :token
end
