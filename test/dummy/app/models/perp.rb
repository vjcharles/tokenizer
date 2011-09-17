class Perp < ActiveRecord::Base
  acts_as_tokenized_thing :default_lifespan => 2.days
end
