# frozen_string_literal: true

require_relative './api'
require_relative './data'
require 'spyke'

module Wordpress
  class Qa < Spyke::Base
    include Spyke::Kaminari::Scopes
    include Data

    def summary
      {
        slug: slug
      }.stringify_keys.to_yaml
    end
  end
end
