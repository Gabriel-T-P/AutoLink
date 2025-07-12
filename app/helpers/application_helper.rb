module ApplicationHelper
  def available_sellers
    @available_sellers ||= Seller.all
  end
end
