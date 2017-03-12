sherlock = Client.create!(name: 'Sherlock Holmes', position: 'Head of Investigation', company: 'Holmes & Watson Ltd.', company_tax_id: 'IRD: 123-456-789', address_line_1: '221b Baker Street', address_line_2: 'London', address_line_3: 'United Kingdom')

usd = Currency.create!(name: 'US Dollar', code: 'USD', symbol: '$')
usd.conversion_rates.create!(valid_from: Time.now.beginning_of_year, valid_to: Time.now.end_of_year, rate: 1.3998.to_d)

pound = Currency.create!(name: 'British Pound', code: 'GBP', symbol: '£')
pound.conversion_rates.create!(valid_from: Time.now.beginning_of_year, valid_to: Time.now.end_of_year, rate: 1.7573.to_d)

invoice = sherlock.invoices.build(date: Time.now, number: 1002, zero_rated_gst: true, discount_in_percents: 10, currency: pound)
invoice.line_items.build(description: 'Software development services', quantity: 55, unit_price: 200)
invoice.line_items.build(description: 'Web hosting', quantity: 1, unit_price: 10)
invoice.save!
