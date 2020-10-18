# frozen_string_literal: true

require_relative './api'
require_relative './renderable'

module Wordpress
  class Page < Spyke::Base
    include Spyke::Kaminari::Scopes
    include Renderable
  end
end
