require 'date'
class TendersController < ApplicationController
  def index
    if params[:regionName].present?
      session[:resoult] = "resoult"
      @tenders = Tender.where('start_date >= ?', params[:dateFrom].to_datetime) if params[:dateFrom].present?

      if @tenders.present? && params['dateTo'].present?
        @tenders = Tender.where(id: @tenders.pluck(:id)).where('end_date <= ?', params[:dateTo].to_datetime)
      else
        @tenders = Tender.where('end_date <= ?', params[:dateTo].to_datetime)
      end

      if @tenders.present? && params['regionName'].first.present?
        @tenders = Tender.where(id: @tenders.pluck(:id)).where(region: params['regionName'])
      elsif params['regionName'].first.present?
        @tenders = Tender.where(region: params['regionName'])
      end

      if @tenders.present? && params['tender_category'].present? && (params['tender_category'] != 'Все')
        @tenders = Tender.where(id: @tenders.pluck(:id)).where(category: params['tender_category']) if params['tender_category'] != 'Все'
      else
        @tenders = Tender.where(category: params['tender_category']) if params['tender_category'] != 'Все'
      end

      if @tender.present? && params[:tender_status].present? && (params[:tender_status] != 'Все')
        @tenders = Tender.where(id: @tenders.pluck(:id)).where(status: params['tender_status']) if ( params[:tender_status] != 'Все')
      else
        @tenders = Tender.where(id: @tenders.pluck(:id)).where(status: params['tender_status']) if ( params[:tender_status] != 'Все')
      end

      @tenders = Tender.all if !@tenders.present?

      @tender_ids = @tenders.pluck(:id)

      @needed_ids = Item.where(tender_id: @tender_ids).pg_search(params[:productName]).pluck(:tender_id)
      if params[:stopName].present?
        @not_need_ids = Item.where(tender_id: @tender_ids).pg_search(params[:stopName]).pluck(:tender_id)
        @tenders = @tenders.where(id: @needed_ids.reject{|x| @not_need_ids.include? x }.uniq)
      else
        @tenders = @tenders.where(id: @needed_ids.uniq)
      end
      @cat_1 = []
      @cat_2 = []
      @cat_3 = []
      @cat_4 = []

      @tenders.each do |tender|
        case tender_weight(tender)
          when 75..100
            @cat_1 << tender
          when 50..74
            @cat_2 << tender
          when 25..49
            @cat_3 << tender
          when 0..24
            @cat_4 << tender
          end
      end
      gon.tenders = @tenders.map{ |tender| [tender.id.to_s, tender.name, tender_weight(tender).to_s + ' %', tender.category, tender.company.name, tender.start_date.strftime('%d, %b, %y'), tender.end_date.strftime('%d, %b, %y'), tender.item_price.to_s]}
      gon.tenders_bubles = @tenders.map{ |tender| [tender.item_price.to_s, tender.start_date.strftime('%d, %b, %y'), tender.item_price, category_select(tender_weight(tender)), tender_weight(tender)]}
      gon.tenders_bubles.insert(0, ['ID', 'Дата', 'Сумма', 'Процедура', 'Доля'])
      @companies = Company.find(@tenders.pluck(:company_id))
      gon.companies = @companies.map {|company| [company.name, @tenders.where(company_id: company.id).count, average_in_month(company, @tenders, params[:dateFrom], params[:dateTo])]}
      gon.companies_with_tenders = @companies.map { |c| [c.name, @tenders.where(company_id: c.id).count]}
      gon.cat_1 = @cat_1.count
      gon.cat_2 = @cat_2.count
      gon.cat_3 = @cat_3.count
      gon.cat_4 = @cat_4.count
    else
      @tenders = Tender.all.order(created_at: :desc)
      session.delete :resoult
    end
  # rescue
  #   @tenders = Tender.all.order(created_at: :desc)
  #   session.delete :resoult
  end

  def index2
    @tenders = Tender.all.order(created_at: :desc)
  end

  def index3

  end

  def tender_details
    respond_to do |format|
      format.js do
        @tender = Tender.find(params[:tender_id])
        @tender_vec = params[:tender_vec].delete('%').strip()
      end
    end
  end

  private

  def check_filter_request
    return true if params[:query] || params[:start_date] || params[:end_date]
    false
  end

  def tender_weight(tender)

    total = tender.items.count.to_f
    matched = tender.items.pg_search(params[:productName]).count.to_f
    return ((100*matched.to_f)/total.to_f).to_i
  end

  def average_in_month(company, tenders, from_date = nil, to_date = nil)
    counts = []
    if from_date.present?
      current_date = from_date.to_date
    else
      current_date = tenders.order(start_date: :asc).first.start_date.to_datetime
    end

    to_date = tenders.order(end_date: :desc).first.end_date.to_datetime unless to_date.present?

    while current_date < to_date.to_date do
      counts << tenders.where(company_id: company.id).where('end_date <= ?', to_date.to_date).count
      current_date = current_date + 30
    end
    return counts.inject{ |sum, el| sum + el }.to_f / counts.size
  end

  def category_select(tw)
    case tw
      when 75..100
        'Категория №1'
      when 50..74
        'Категория №2'
      when 25..49
        'Категория №3'
      when 0..24
        'Категория №4'
      end
  end
end
