# frozen_string_literal: true

require_relative './api'
require_relative './data'
require 'spyke'

module Wordpress
  class SocialNetwork < Spyke::Base
    include Spyke::Kaminari::Scopes
    include Data

    def summary
      {
        name: name,
        description: description,
        url: url
      }.stringify_keys.to_yaml
    end
  end
end
