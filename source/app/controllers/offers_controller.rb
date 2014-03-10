class OffersController < ApplicationController
  def index
    @offers = Offer.all
  end

  def crawl
    Offer.crawl!

    redirect_to root_path
  end
end
