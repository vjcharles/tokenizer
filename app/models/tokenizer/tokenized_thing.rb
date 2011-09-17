module Tokenizer
  class TokenizedThing < ActiveRecord::Base
    validates_uniqueness_of :token

    def is_expired?
      Time.zone.now.to_f > self.lifespan.to_f + self.created_at.to_f
    end

    def is_not_expired?
      !is_expired?
    end

    # create record from params
    def create_record!
      new_instance = nil
      return false if is_expired?
      begin
        klass = Kernel.const_get(class_name)
        new_instance = klass.new(JSON.parse parameters)
        new_instance[:done_at] = Time.zone.now
        new_instance.save
        update_attribute(:lifespan, 0)#so this can be removed at next sweep
        new_instance
      rescue NameError => e
        return false
      end
    end

    def new_record
      begin
        klass = Kernel.const_get(class_name)
        klass_params = JSON.parse parameters
        klass_params.delete(:id)
        new_instance = klass.new(klass_params)
      rescue NameError => e
        return false
      end
      
    end
  end
end

