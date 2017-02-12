500.times do
  Tender.create(
                name: Faker::Name.name,
                company_id: rand(1..3),
                start_date: Faker::Time.between(2.days.ago, Date.today, :all),
                end_date: Faker::Time.between(Time.now, Date.today + 4.days, :all),
                item_price: rand(1.5..9999.999),
                address: Faker::Address.street_name
                )
end
500.times do
  Item.create(
                content: Faker::Commerce.department(10),
                tender_id: rand(1..500),
                quantity: Faker::Number.number(rand(1..10)),
                price_one: Faker::Number.number(rand(1..10)),
                price_all: Faker::Number.number(rand(1..10))
                )
end
@region = [
    'Адыгея респ.',
    'Алтай респ.',
    'Башкортостан респ.',
    'Бурятия респ.',
    'Дагестан респ.',
    'Ингушетия респ.',
    'Кабардино-Балкарская респ.',
    'Калмыкия респ.',
    'Карачаево-Черкесская респ.',
    'Карелия респ.',
    'Коми респ.',
    'Марий Эл респ.',
    'Мордовия респ.',
    'Саха (Якутия)',
    'Северная Осетия — Алания',
    'Татарстан респ.',
    'Тыва (Тува) респ.',
    'Удмуртская респ.',
    'Хакасия респ.',
    'Чеченская респ.',
    'Чувашская респ.',
    'Автономная республика Крым',
    'Алтайский край',
    'Забайкальский край',
    'Камчатский край',
    'Краснодарский край',
    'Красноярский край',
    'Пермский край',
    'Приморский край',
    'Ставропольский край',
    'Хабаровский край',
    'Амурская обл.',
    'Архангельская обл.',
    'Астраханская обл.',
    'Белгородская обл.',
    'Брянская обл.',
    'Владимирская обл.',
    'Волгоградская обл.',
    'Вологодская обл.',
    'Воронежская обл.',
    'Ивановская обл.',
    'Иркутская обл.',
    'Калининградская обл.',
    'Калужская обл.',
    'Кемеровская обл.',
    'Кировская обл.',
    'Костромская обл.',
    'Курганская обл.',
    'Курская обл.',
    'Ленинградская обл.',
    'Липецкая обл.',
    'Магаданская обл.',
    'Московская обл.',
    'Мурманская обл.',
    'Нижегородская обл.',
    'Новгородская обл.',
    'Новосибирская обл.',
    'Омская обл.',
    'Оренбургская обл.',
    'Орловская обл.',
    'Пензенская обл.',
    'Псковская обл.',
    'Ростовская обл.',
    'Рязанская обл.',
    'Самарская обл.',
    'Саратовская обл.',
    'Сахалинская обл.',
    'Свердловская обл.',
    'Смоленская обл.',
    'Тамбовская обл.',
    'Тверская обл.',
    'Томская обл.',
    'Тульская обл.',
    'Тюменская обл.',
    'Ульяновская обл.',
    'Челябинская обл.',
    'Ярославская обл.',
    'Москва',
    'Санкт-Петербург',
    'Севастополь',
    'Еврейская авт. обл.',
    'Ненецкий авт. окр.',
    'Ханты-Мансийский авт. окр.',
    'Чукотский авт. окр.',
    'Ямало-Ненецкий авт. окр.'
  ]
400.times do
  Company.create(
            name: Faker::Company.name,
            region_id: @region[rand(0..60)]
            )
end
Tender.all.each do |t|
  t.update(company_id: rand(0..400))
end
Tender.all.each do |t|
  t.update(category: rand(0..5), status: [0, 1].sample)
end
Tender.all.each do |t|
  t.update(start_date: Faker::Date.forward(rand(50..100)), end_date: Faker::Date.forward(rand(120..150)) )
end
# require 'csv'

# csv_text = File.read('companies.csv')
# csv = CSV.parse(csv_text, :headers => true)
# csv.each do |row|
#   Company.create!(row.to_hash)
# end


# csv_text = File.read('tenders.csv')
# csv = CSV.parse(csv_text, :headers => true)
# csv.each do |row|
#   Tender.create!(row.to_hash)
# end

# csv_text = File.read('items.csv')
# csv = CSV.parse(csv_text, :headers => true)
# csv.each do |row|
#   Item.create!(row.to_hash)
# end
