# frozen_string_literal: true

require 'cgi'
require 'oj'
require 'spyke'
require 'spyke/kaminari'
require 'uri'

module Wordpress
  BASE_URL = 'https://cms.freesharing.eu'.freeze
  ENDPOINT = 'https://cms.freesharing.eu/wp-json/wp/v2'.freeze

  class HeaderParser < Faraday::Response::Middleware
    def pagination_headers(env)
      uri = URI(env[:url])
      page = if uri.query
        query = CGI.parse(uri.query)
        query['page'].first.to_i
      end

      page = 1 if page.nil?
      total_pages = env[:response_headers]['X-WP-TotalPages'].to_i

      Hash.new.tap do |hash|
        hash['X-Page'] = page
        hash['X-Next-Page'] = page + 1 if page < total_pages
        hash['X-Prev-Page'] = page - 1 if page > 1
        hash['X-Total'] = env[:response_headers]['X-WP-Total'].to_i
        hash['X-Total-Pages'] = total_pages
        hash['X-Per-Page'] = 10
      end
    end

    def on_complete(env)
      env[:response_headers].merge!(pagination_headers(env))
    end
  end

  class JSONParser < Faraday::Response::Middleware
    def result(data: {}, metadata: {}, errors: [])
      {
        data: data,
        metadata: metadata,
        errors: errors
      }
    end

    def parse(body)
      json = Oj.load(body, symbol_keys: true)
      return result(errors: [json]) if json.try(:code).present?

      result(data: json)
    end
  end
end

Spyke::Base.connection = Faraday.new(url: Wordpress::ENDPOINT, ssl: { verify: false }) do |c|
  c.request :json
  c.use     Spyke::Kaminari::HeaderParser
  c.use     Wordpress::HeaderParser
  c.use     Wordpress::JSONParser
  c.adapter Faraday.default_adapter
end
