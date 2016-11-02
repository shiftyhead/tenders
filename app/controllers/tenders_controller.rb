require 'date'
class TendersController < ApplicationController
  def index
    if params[:regionName].present?
      @tenders = Tender.where('start_date >= ?', params[:dateFrom].to_datetime)
      @tenders = Tender.where(id: @tenders.pluck(:id)).where('end_date <= ?', params[:dateTo].to_datetime)
      @tenders = Tender.where(id: @tenders.pluck(:id)).where(region: params['regionName'])
      @tender_ids = @tenders.pluck(:id)
      @needed_ids = Item.where(tender_id: @tender_ids).pg_search(params[:productName]).pluck(:tender_id)
      if params[:stopName].present?
        @not_need_ids = Item.where(tender_id: @tender_ids).pg_search(params[:stopName]).pluck(:tender_id)
        @tenders = @tenders.where(id: @needed_ids.reject{|x| @not_need_ids.include? x }.uniq)
      else
        @tenders = @tenders.where(id: @needed_ids.uniq)
      end
    else
      @tenders = Tender.all.order(created_at: :desc)
    end
  end

  def index2

  end

  def index3

  end

  private
  def check_filter_request
    return true if params[:query] || params[:start_date] || params[:end_date]
    false
  end
end
