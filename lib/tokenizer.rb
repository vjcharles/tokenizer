require "tokenizer/engine"

module Tokenizer
  module ActsAsTokenizedThing
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def acts_as_tokenized_thing(options = {})
        cattr_accessor :default_lifespan
        self.default_lifespan = options[:default_lifespan].to_i || 1.day.to_i
      end

      def tokenizer
        Tokenizer::TokenizedThing
      end

    end

    def tokenize_me(options = {})
      attributes = {:class_name => self.class.to_s,
                    :lifespan => self.class.default_lifespan,
                    :parameters => self.attributes.to_json}

      if options[:token].blank?
        #unique check?
        options[:token] = SecureRandom::hex(40).to_s + "_" + Time.now.to_i.to_s
      end
      attributes.merge! options
      TokenizedThing.create!(attributes)
    end
  end
end
ActiveRecord::Base.send :include, Tokenizer::ActsAsTokenizedThing
