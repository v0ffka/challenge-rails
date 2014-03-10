require 'spec_helper'

describe Offer do
  it "should crawl the API and create offers in the database." do
    Offer.crawl!
    Offer.count.should_not eq(0)
  end

  it "should be able to crawl the API multiple times and not create duplicate offers" do
    Offer.crawl!
    offer_count_before = Offer.count
    Offer.crawl!
    Offer.count.should eq(offer_count_before)
  end

end