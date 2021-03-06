# frozen_string_literal: true

require 'erb'
require 'nokogiri'

module Wordpress
  module Renderable
    extend ActiveSupport::Concern

    def render
      template = "./lib/wp/templates/#{type}.html.erb"
      template = './lib/wp/templates/page.html.erb' unless File.exists?(template)

      ERB.new(File.read(template)).result(binding)
    end
  end
end
