require 'spec_helper'

describe OffersController do
  render_views

  it "should crawl for and create offers when clicking on the button and then display them. reloading the page should still show the offers" do
    visit '/'
    expect(page).to have_content('0 Offers')
    click_button 'Crawl!'
    offer_cnt = Offer.count
    expect(page).to have_content("#{offer_cnt} Offers")
    expect(page).to have_xpath('//div[@class="offer"]')
    visit '/'
    expect(page).to have_content("#{offer_cnt} Offers")
    expect(page).to have_xpath('//div[@class="offer"]')
  end
end
