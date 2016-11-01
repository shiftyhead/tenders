require 'date'
class TendersController < ApplicationController
  def index

    if check_filter_request

      @tenders = Tender.pg_search(params[:query]) if params[:query].present?
      if params[:start_date].present?
        @tenders = Tender.where(id: @tenders.pluck(:id)).where('start_date >= ?', params[:start_date].to_datetime) if @tenders.present?
      else
        @tenders = Tender.where('start_date >= ?', params[:start_date].to_datetime)
      end
      if params[:end_date].present?
        @tenders = Tender.where(id: @tenders.pluck(:id)).where('end_date <= ?', params[:end_date].to_datetime) if @tenders.present?
      else
        @tenders = Tender.where('end_date <= ?', params[:end_date].to_datetime)
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
