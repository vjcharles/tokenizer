require "test_helper"

module Tokenizer
  class TokenizedThingTest < ActiveSupport::TestCase
    test "derp should have tokenized class method 'default_lifespan that can be set" do
      assert_equal 1.day, Derp.default_lifespan
    end

    test "perp should have a customized default_lifespan method" do
      assert_equal 2.days, Perp.default_lifespan
    end

    def setup
      @d = Derp.new(:message => "doop")
      @p = Perp.new(:message => "pood")
      @tokenized_thing = @d.tokenize_me
      @tokenized_thing2 = @p.tokenize_me
    end

    def teardown
    end

    test "derp should have an instance tokenize_me method and return a tokenized thing" do
      assert @d.respond_to? :tokenize_me
      assert_equal Derp.to_s, @tokenized_thing.class_name.to_s

      assert_equal TokenizedThing.name, @tokenized_thing.class.name
      assert_instance_of TokenizedThing, @tokenized_thing
    end

    test "derp tokenize_me should save the class_name" do
      assert_equal @d.class.to_s, @tokenized_thing.class_name
    end

    test "tokenize_me should set the lifespan attribute by default_lifespan setting" do
      assert @tokenized_thing.respond_to? :lifespan
      #this isn't true. needs to mock 1 day from now.
      assert_equal 1.day, @tokenized_thing.lifespan
      assert_equal Derp.default_lifespan, @tokenized_thing.lifespan
    end

    test "derp attributes should be saved in tokenized thing parameters attr" do
      assert_equal @d.attributes.to_json, @tokenized_thing.parameters, @d.attributes.to_json
    end

    test "optional parameters should be saved with tokenized thing" do
      options = {:redirect_url_success => "http://hi.com",
                 :redirect_url_failure => "http://bye.com",
                 :lifespan => 3.days, #overrides default
                 :token => "unique_token", #this shouldn't be allowed, tokenizer should do this
      }

      @tokenized_thing = @d.tokenize_me(options)
      assert_equal "http://hi.com", @tokenized_thing.redirect_url_success
      assert_equal "http://bye.com", @tokenized_thing.redirect_url_failure
      assert_equal 3.days, @tokenized_thing.lifespan #this is not right
      assert_equal "unique_token", @tokenized_thing.token
    end

    test "token overridden if supplied" do
      @tokenized_thing = @d.tokenize_me(:token => "me")
      assert_equal "me", @tokenized_thing.token
    end
    test "big random unique token if not supplied" do
      @tokenized_thing = @d.tokenize_me
      assert !@tokenized_thing.token.blank?, @tokenized_thing.inspect
      assert 80 <= @tokenized_thing.token.length
    end
    test "handle duplicate token exception gracefully" do
      @tokenized_thing = @d.tokenize_me(:token => "NOT_UNIQUE")
      assert_equal "NOT_UNIQUE", @tokenized_thing.token
      assert_raise ActiveRecord::RecordInvalid do
        @d.tokenize_me(:token => "NOT_UNIQUE")
      end
    end

    test "Tokenized thing should be expired if lifespan is 0" do
      @tokenized_thing = @d.tokenize_me(:lifespan => 0.days)
      assert @tokenized_thing.is_expired?, "time.zone.now:" + Time.zone.now.to_s + "  lifespan: " + @tokenized_thing.lifespan.to_s + "  created_at: " + @tokenized_thing.created_at.to_s
    end
    test "Tokenized thing should not be expired if lifespan is greater than now + lifespan" do
      @tokenized_thing = @d.tokenize_me(:lifespan => 1.day)
      assert !@tokenized_thing.is_expired?
    end
    test "Object should have access to active record find methods on TokenizedThings." do
      assert_respond_to Derp, :tokenizer
      assert_respond_to Derp.tokenizer, :find
      assert_equal Derp.tokenizer, Tokenizer::TokenizedThing
      assert_equal Derp.tokenizer.first, Tokenizer::TokenizedThing.first
      assert_equal Derp.tokenizer.find_by_class_name('Derp'),
        Tokenizer::TokenizedThing.find_by_class_name('Derp')
    end
    test "TokenizedThing class should only find its own types unless explicity set otherwise" do
      assert_equal Tokenizer::TokenizedThing.find(:all).length, 2
      assert_equal Tokenizer::TokenizedThing.find_by_class_name('Derp'), Derp.tokenizer.find(:all)
      assert_equal 1, Derp.tokenizer.find(:all).length
    end
  end
end
