require 'net/http'
require 'uri'

module Crawling
  def crawl!
    lss_client = LssClient.new
    lss_response = lss_client.links
    do_import(lss_response['link'])
  end

  private
  def do_import offers
    add_offers(offers)
  end

  #very simple and not optimal
  def add_offers offers
    Offer.transaction do
      offers.each do |offer|
        link_id = offer['link_id']
        description = offer['description']
        url = offer['destination']
        #there were cases with empty link and description ...
        title = offer['link_name'] || url
        merch = add_merchant(offer['advertiser_id'], offer['advertiser_name'])

        offer = Offer.find_or_initialize_by(:link_id => link_id)
        offer.update_attributes!(:description => description, :title => title, :url => url, :merchant_id => merch.id)
      end
    end
  end

  def add_merchant merch_id, merch_name
    merchant = Merchant.find_or_initialize_by(:cid => merch_id)
    merchant.update_attributes!(:name => merch_name)
    merchant
  end

  class LssClient
    def initialize
      uri = URI(Settings.lss.url)
      @http = Net::HTTP.new(uri.host, uri.port)
      @http.use_ssl = true
    end

    def links(page = 1, per_page = Settings.lss.records_per_page)
      uri = URI(Settings.lss.url)
      uri.query = URI.encode_www_form({'website-id' => Settings.lss.website_id,
                                       'page-number' => page,
                                       'records-per-page' => per_page})

      request = Net::HTTP::Get.new(uri)
      request['authorization'] = Settings.lss.api_key
      response = @http.request(request)

      Hash.from_xml(response.body)['cj_api']['links']
    end
  end
end