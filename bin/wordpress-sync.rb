# frozen_string_literal: true

require 'spyke'
require 'oj'

class JSONParser < Faraday::Response::Middleware
  def result(data: {}, metadata: {}, errors: {})
    {
      data: data,
      metadata: metadata,
      errors: errors
    }
  end

  def parse(body)
    json = Oj.load(body, symbol_keys: true)
    return result(errors: json) if json.try(:code).present?

    result(data: json)
  end
end

Spyke::Base.connection = Faraday.new(url: 'https://freesharing.eu/wp-json/wp/v2') do |c|
  c.request :json
  c.use     JSONParser
  c.adapter Faraday.default_adapter
end

class Page < Spyke::Base
end

class Organization < Spyke::Base
  uri 'organization(/:id)'
end

puts Page.find(206).content[:rendered]
