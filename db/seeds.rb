# 500.times do
#   Tender.create(
#                 name: Faker::Name.name,
#                 company_id: rand(1..3),
#                 start_date: Faker::Time.between(2.days.ago, Date.today, :all),
#                 end_date: Faker::Time.between(Time.now, Date.today + 4.days, :all),
#                 item_price: rand(1.5..9999.999),
#                 address: Faker::Address.street_name
#                 )
# end
