Tokenizer
=========

## to get this running from within an app ##

    mount Tokenizer::Engine => "/tokenizer", :as => "tokenizer_engine"

    rake tokenizer:install:migrations

files will be copied, then run:

    rake db:migrate

    get "simulate/tokenized_thing"

go here: http://localhost:4000/tokenizer/


## Using in your app ##

add `acts_as_tokenized_thing` to a model.

that adds the the method your_resource.tokenize_me

    acts_as_tokenized_thing :default_lifespan => 1.day

if not specified 1 day will be used.

## example use in rails console ##

creating a user action without saving it
  an_action = UserAction.new(actual_value: 10, priority_id: 1, user_id: 1, done_at: Time.now)
  an_action.tokenize_me

you can find tokenized values like so: 

  Tokenizer::TokenizedThing.all

* There is no user_action id, because it doesn't exist yet.



## Engine Design ##

* Make engine

    rails plugin new tokenizer --mountable

* Mount the engine in your_app/config/routes

    mount Tokenizer::Engine => "/tokenizer"

* To access engine paths from within the parent app, 

    mount Tokenizer::Engine => "/tokenizer", :as => "tokenizer_engine"

in a view 

    redirect_to tokenizer_engine.root_path

* From within the engine

    <%= link_to "Simulate Tokenized Thing", main_app.simulate_tokenized_thing_path %>

* Generating the tokenized_thing

    rails g model tokenized_thing class_name:string token:string parameters:text redirect_url_success:string redirect_url_failure:string lifespan:datetime 

* Run

    rake db:create
    rake db:migrate

make a test object

    Tokenizer::TokenizedThing.create!(:class_name => 'UserAction', :token => 'a_unique_token', :parameters => '{"this": "is", "a": "JSON", "string": "bitches"}', :lifespan => Time.now + 1.year)


## Tests ## 

    cd tokenizer/test
    ruby -Itest test/unit/tokenizer/tokenized_thing_test.rb

## TODOs ##

* sweep through and delete old tokens

* test coverage

## Thanks ##

Thanks to (http://railscasts.com/episodes/277-mountable-engines)[Ryan Bates]

