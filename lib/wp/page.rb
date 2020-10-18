# frozen_string_literal: true

require_relative './api'

module Wordpress
  class Page < Spyke::Base
    include Spyke::Kaminari::Scopes
  end
end
