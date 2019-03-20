require 'csv'

namespace :data do
  desc "Imports invoices and expenses from CSV"

  task import: :environment do
    data_directory = "/home/deploy/"

    # Rake::Task["db:drop"].invoke
    # Rake::Task["db:create"].invoke
    # Rake::Task["db:migrate"].invoke

    usd = Currency.create!(name: 'US Dollar', code: 'USD', symbol: '$')
    usd.conversion_rates.create!(valid_from: Time.new(2016).beginning_of_year, valid_to: Time.new(2016).end_of_year, rate: 1.4365.to_d)
    usd.conversion_rates.create!(valid_from: Time.new(2017).beginning_of_year, valid_to: Time.new(2017).end_of_year, rate: 1.4023.to_d)

    nzd = Currency.create!(name: 'New Zealand Dollar', code: 'NZD', symbol: '$')
    nzd.conversion_rates.create!(valid_from: Time.new(2000).beginning_of_year, valid_to: Time.new(2099).end_of_year, rate: 1.to_d)

    CSV.foreach("#{data_directory}clients.csv") do |row|
      group = row[0].try(:strip)
      currency = Currency.find_by(code: row[1].try(:strip))
      zero_rated_gst = row[2].try(:strip) == 'Yes'
      name = row[3].try(:strip)
      position = row[4].try(:strip)
      email = row[5].try(:strip)
      company = row[6].try(:strip)
      address_line_1 = row[7].try(:strip)
      address_line_2 = row[8].try(:strip)
      address_line_3 = row[9].try(:strip)
      address_line_4 = row[10].try(:strip)

      unless client = Client.find_by(company: company)
        client = Client.new(group: group, company: company, address_line_1: address_line_1, address_line_2: address_line_2, address_line_3: address_line_3, address_line_4: address_line_4)
      end
        client.contacts.build(name: name, position: position, email: email)
        client.save!
    end

    nzd = Currency.find_by(code: 'NZD')
    CSV.foreach("#{data_directory}expenses.csv") do |row|
      date = Date.strptime(row[0].strip, "%d/%m/%Y")
      description = row[1].strip
      value = BigDecimal(row[2].strip[1..-1])
      includes_gst = row[4].present?
      nzd.expenses.create!(value: value, includes_gst: includes_gst, description: description, date: date)
    end

    invoice = nil
    csv_contents = CSV.read("#{data_directory}invoices.csv")
    csv_contents.shift
    csv_contents.each do |row|
      if row[0].nil?
        description = row[1].strip
        quantity = row[2].strip.to_i
        unit_price = BigDecimal(row[3].strip[1..-1])
        invoice.line_items.build(description: description, quantity: quantity, unit_price: unit_price)
      else
        invoice.save! unless invoice.nil?
        date = Date.strptime(row[0].strip, "%d/%m/%Y")
        contact = Contact.find_by(email: row[1].strip)
        number = row[2].strip
        zero_rated_gst = row[3].try(:strip) == 'No'
        currency = Currency.find_by(code: row[4].strip)
        discount = row[5].nil? ? 0 : row[5].strip.to_i
        status = :paid

        invoice = Invoice.new(contact: contact, currency: currency, date: date, zero_rated_gst: zero_rated_gst, number: number, discount_in_percents: discount, status: status)
      end
    end
  end
end
