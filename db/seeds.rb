nzd = Currency.create!(name: 'New Zealand Dollar', code: 'NZD', symbol: '$')
nzd.conversion_rates.create!(valid_from: Time.new(2000).beginning_of_year, valid_to: Time.new(2099).end_of_year, rate: 1.to_d)

pound = Currency.create!(name: 'British Pound', code: 'GBP', symbol: '£')
pound.conversion_rates.create!(valid_from: Time.now.beginning_of_year, valid_to: Time.now.end_of_year, rate: 1.7573.to_d)

client = Client.new(company: 'Investigation Services Ltd.', address_line_1: '221b Baker Street', address_line_2: 'London', address_line_3: 'United Kingdom', group: 'software')

sherlock = client.contacts.build(name: 'Sherlock Holmes', email: 'sherlock@investigation.co.uk', position: 'Head of Investigation')

client.save!

invoice = sherlock.invoices.build(date: Time.now, number: 1001, zero_rated_gst: true, discount_in_percents: 10, currency: pound, status: :paid)

another_invoice = sherlock.invoices.build(date: Time.now, number: 1002, zero_rated_gst: true, discount_in_percents: 10, currency: pound, status: :paid)
another_invoice.line_items.build(description: 'Software development services', quantity: 10, unit_price: 200)
another_invoice.save!

unpaid_invoice = sherlock.invoices.build(date: Time.now, number: 1003, zero_rated_gst: true, discount_in_percents: 10, currency: pound, status: :unpaid)
unpaid_invoice.line_items.build(description: 'Software development services', quantity: 5, unit_price: 200)
unpaid_invoice.save!

Expense.create!(currency: pound, value: 22.5, date: Time.now, includes_gst: false, description: 'Underground Tickets')
Expense.create!(currency: pound, value: 100, date: Time.now, includes_gst: false, description: 'Violin')
Expense.create!(currency: nzd, value: 10, date: Time.now, includes_gst: true, description: 'Sandwich')
