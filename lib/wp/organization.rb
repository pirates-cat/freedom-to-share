# frozen_string_literal: true

require 'spyke'

module Wordpress
  class Organization < Spyke::Base
    uri 'organization(/:id)'
  end
end
