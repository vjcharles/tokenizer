module Tokenizer
  class TokenizedThingsController < ApplicationController
    def index
      @things = TokenizedThing.all
    end

    #todo: shouldn't this have a session fixation token passed in? it's a get that performs a descructive action too
    def token
      token = params[:token]
      if token.blank?
        render :inline => 'failure: no token'#this won't be called with current routes
      end

      tokenized = Tokenizer::TokenizedThing.where(:token => token).first
      if tokenized.blank?
        render :inline => 'failure: bad token'
      elsif tokenized.is_not_expired?
        #todo: do make the object from it
        tokenized.create_record!

        if tokenized.redirect_url_success #redirect failutre if needed. not sure the case. basically if the object isn't successfully created.
          redirect_to tokenized.redirect_url_success
        else
          render :inline => 'success'
        end
      else
        if tokenized.redirect_url_failure #redirect failutre if needed. not sure the case. basically if the object isn't successfully created.
          redirect_to tokenized.redirect_url_success
        else
          render :inline => 'failure: token expired'
        end
      end
    end
    #protected
    #def self.link_to(thing)
    #  if thing.class != TokenizedThing
    #    raise "asdf".inspect
    #  end
    #  link = link_to thing
    #end
  end
end
