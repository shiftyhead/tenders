require 'date'
class TendersController < ApplicationController
  def index
    begin
      session[:resoult] = "resoult"

      @tenders = Tender.where('start_date >= ?', params[:dateFrom].to_datetime) if params[:dateFrom].present?

      if @tenders.present? && params['dateTo'].present?
        @tenders = @tenders.map { |t| t if t.end_date <= params[:dateTo].to_datetime }.compact
      elsif params['dateTo'].present?
        @tenders = Tender.where('end_date <= ?', params[:dateTo].to_datetime)
      end

      if @tenders.present? && params['regionName'].first.present?
        @tenders = @tenders.map { |t| t if t.region == params[:regionName] }.compact
      elsif params['regionName'].first.present?
        @tenders = Tender.where(region: params['regionName'])
      end

      if @tenders.present? && params['tender_category'].present? && (params['tender_category'] != 'Все')
        @tenders = @tenders.map { |t| t if t.category == params['tender_category'] }.compact if params['tender_category'] != 'Все'
      elsif params['tender_category'].present? && (params['tender_category'] != 'Все')
        @tenders = Tender.where(category: params['tender_category']) if params['tender_category'] != 'Все'
      end

      if @tenders.present? && params[:tender_status].present? && (params[:tender_status] != 'Все')
        @tenders = @tenders.map { |t| t if t.status == params['tender_status']}.compact if ( params[:tender_status] != 'Все')
      end

      @tender_ids = @tenders.pluck(:id) if @tenders.present?

      if @tender_ids.present?
        @needed_ids = Item.where(tender_id: @tender_ids).pg_search(params[:productName]).pluck(:tender_id)
        if params[:stopName].present?
          @not_need_ids = Item.where(tender_id: @tender_ids).pg_search(params[:stopName]).pluck(:tender_id)
          in_array = @needed_ids.reject{|x| @not_need_ids.include? x }.uniq rescue @needed_ids
          @tenders = @tenders.select { |t| t.id.in? in_array }
        else
          @tenders = @tenders.map { |t| t if @needed_ids.uniq.include?(t.id) }.compact
        end
      elsif params[:productName].present?
        @needed_ids = Item.pg_search(params[:productName]).pluck(:tender_id)
        if params[:stopName].present?
          @not_need_ids = Item.pg_search(params[:stopName]).pluck(:tender_id)
          in_array = @needed_ids.reject{|x| @not_need_ids.include? x }.uniq rescue @needed_ids
          @tenders = Tender.where(id: in_array )
        else
          @tenders = Tender.where(id: @needed_ids.uniq )
        end
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
      @tenders_bubles = @tenders.map{ |tender| [tender.item_price.to_s, tender.start_date.strftime('%d, %b, %y'), tender.item_price, category_select(tender_weight(tender)), tender_weight(tender)]}
      gon.tenders_bubles = @tenders.map{ |tender| [tender.item_price.to_s, tender.start_date.strftime('%d, %b, %y'), tender.item_price, category_select(tender_weight(tender)), tender_weight(tender)]}

      gon.tenders_bubles.insert(0, ['ID', 'Дата', 'Сумма', 'Процедура', 'Доля'])
      @companies = Company.find(@tenders.pluck(:company_id))
      gon.companies = @companies.map {|company| [company.name, @tenders.map { |t| t if t.company_id == company.id}.compact.count, average_in_month(company, @tenders, params[:dateFrom], params[:dateTo])]}
      gon.companies_with_tenders = @companies.map { |c| [ c.name, @tenders.map{ |t| t if t.company_id == c.id }.compact.count ] }
      gon.cat_1 = @cat_1.count
      gon.cat_2 = @cat_2.count
      gon.cat_3 = @cat_3.count
      gon.cat_4 = @cat_4.count

    rescue
      @tenders = []
      session.delete :resoult
    end

    hight_charts( @cat_1, @cat_2, @cat_3, @cat_4 )
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

  def hight_charts( cat_1 = nil, cat_2 = nil, cat_3 = nil, cat_4 = nil )
    @charts = LazyHighCharts::HighChart.new('graph') do |f|
      # f.title(text: "Распределение тендеров")
      f.plotOptions(series: {dataLabels: {enabled: true ,format: '{point.y}', style: { color: 'black', fontSize: "8px"} }, point: { events: { click: "click_function"} }})
      f.series(name: "категория 1 (75-100%)", color: 'rgba(255, 255, 0, 0.4)',
        yAxis: 0,tooltip: {
                  useHTML: true,
                  headerFormat: '<table>',
                  pointFormat: '<tr><th colspan="2"><h3>{point.y}</h3></th></tr>'+ '<br>' +
                      '<tr><th> Дата:</th><td>{point.date}</td></tr>' +'<br>' +
                      '<tr><th>Сумма:</th><td>{point.y}</td></tr>' +'<br>' +
                      '<tr><th>Доля:</th><td>{point.z}%</td></tr>',
                  footerFormat: '</table>',
                  followPointer: true }, data: cat_1.map { |result| {id: result.id.to_s , x: result.start_date.utc.to_i*1000, y: result.item_price.to_f, z: tender_weight( result ) , name: result.name, date: result.start_date.to_date}}
      ) if cat_1.present?
      f.series(name: "категория 2 (50-75%)", color: 'rgba(255, 0, 0, 0.4)',
        yAxis: 0,tooltip: {
                  useHTML: true,
                  headerFormat: '<table>',
                  pointFormat: '<tr><th colspan="2"><h3>{point.y}</h3></th></tr>'+ '<br>' +
                      '<tr><th> Дата:</th><td>{point.date}</td></tr>' +'<br>' +
                      '<tr><th>Сумма:</th><td>{point.y}</td></tr>' +'<br>' +
                      '<tr><th>Доля:</th><td>{point.z}%</td></tr>'},
                  footerFormat: '</table>', data: cat_2.map { |result| {id: result.id.to_s , x: result.start_date.utc.to_i*1000, y: result.item_price.to_f, z: tender_weight( result ) , name: result.name, date: result.start_date.to_date}}
      ) if cat_2.present?
      f.series(name: "категория 3 (25-50%)", color: 'rgba(33, 193, 58, 0.4)',
        yAxis: 0,tooltip: {
                  useHTML: true,
                  headerFormat: '<table>',
                  pointFormat: '<tr><th colspan="2"><h3>{point.y}</h3></th></tr>'+ '<br>' +
                      '<tr><th> Дата:</th><td>{point.date}</td></tr>' +'<br>' +
                      '<tr><th>Сумма:</th><td>{point.y}</td></tr>' +'<br>' +
                      '<tr><th>Доля:</th><td>{point.z}%</td></tr>',
                  footerFormat: '</table>'}, data: cat_3.map { |result| {id: result.id.to_s , x: result.start_date.utc.to_i*1000, y: result.item_price.to_f, z: tender_weight( result ) , name: result.name, date: result.start_date.to_date}}
      ) if cat_3.present?
      f.series(name: "категория 4 (0-25%)", color: 'rgba(43, 0, 251, 0.5)',
        yAxis: 0,tooltip: {
                  useHTML: true,
                  headerFormat: '<table>',
                  pointFormat: '<tr><th colspan="2"><h3>{point.y}</h3></th></tr>'+ '<br>' +
                      '<tr><th> Дата:</th><td>{point.date}</td></tr>' +'<br>' +
                      '<tr><th>Сумма:</th><td>{point.y}</td></tr>' +'<br>' +
                      '<tr><th>Доля:</th><td>{point.z}%</td></tr>',
                  footerFormat: '</table>'}, data: cat_4.map { |result| {id: result.id.to_s , x:  result.start_date.utc.to_i*1000, y: result.item_price.to_f, z: tender_weight( result ) , name: result.name, date: result.start_date.to_date}}
      ) if cat_4.present?
      f.yAxis [
        {title: {text: "Цена контракта, млн. руб.", margin: 10} }

      ]

      f.xAxis(type: 'datetime',
        dateTimeLabelFormats: {
                               day: '%e. %b', week: '%e. %b',
                               month: '%b \'%y', year: '%Y'})
      f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
      f.chart({defaultSeriesType: "bubble",plotBorderWidth: 1, zoomType: 'xy'})
      f.colors(["#90ed6d", "#f7a34c", "#8085e8", "#f15c79"])
    end
  end

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
      current_date = tenders.sort_by(&:start_date).first.start_date.to_datetime
    end
    to_date = tenders.sort_by(&:start_date).first.end_date.to_datetime unless to_date.present?

    while current_date < to_date.to_date do
      counts << tenders.map { |t| t if ( ( t.company_id == company.id ) && ( t.end_date <= to_date.to_date ) ) }.compact.count
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
