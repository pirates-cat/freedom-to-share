# frozen_string_literal: true

module Wordpress
  module Data
    extend ActiveSupport::Concern

    class_methods do
      def filename
        name = self.name.demodulize.tableize
        File.join('data', "#{name}.yml")
      end
    end
  end
end
