class Tweet < ApplicationRecord
  resourcify 
  belongs_to :user
end
