# frozen_string_literal: true

require 'erb'

module Wordpress
  module Renderable
    include ActiveSupport::Concern

    def render
      type = self.class.name.demodulize.downcase
      ERB.new(File.read("./templates/#{type}.html.erb")).result(binding)
    end
  end
end
