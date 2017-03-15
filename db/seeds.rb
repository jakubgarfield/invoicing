usd = Currency.create!(name: 'US Dollar', code: 'USD', symbol: '$')
usd.conversion_rates.create!(valid_from: Time.new(2016).beginning_of_year, valid_to: Time.new(2016).end_of_year, rate: 1.4365.to_d)
usd.conversion_rates.create!(valid_from: Time.new(2017).beginning_of_year, valid_to: Time.new(2017).end_of_year, rate: 1.4023.to_d)

nzd = Currency.create!(name: 'New Zealand Dollar', code: 'NZD', symbol: '$')
nzd.conversion_rates.create!(valid_from: Time.new(2000).beginning_of_year, valid_to: Time.new(2099).end_of_year, rate: 1.to_d)
