class Offer < ActiveRecord::Base
  belongs_to :merchant
  extend Crawling
end
