# frozen_string_literal: true

require_relative './api'
require_relative './data'
require 'spyke'

module Wordpress
  class News < Spyke::Base
    include Spyke::Kaminari::Scopes
    include Data

    def summary
      {
        name: name,
        url: url,
        country: country,
        language: language,
        published_at: published_at
      }.stringify_keys.to_yaml
    end
  end
end
