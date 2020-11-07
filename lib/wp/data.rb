# frozen_string_literal: true

require 'uri'

module Wordpress
  module Data
    extend ActiveSupport::Concern

    class_methods do
      def filename
        name = self.name.demodulize.tableize
        File.join('data', "#{name}.yml")
      end
    end

    def prepare; end

    def download(url, resource)
      uri = URI.parse(url)
      name = self.class.name.demodulize.tableize
      filename = uri.path.split('/').last

      basepath = File.join('source', resource.to_s, name)
      filepath = File.join('source', resource.to_s, name, filename)

      http_conn = Faraday.new(ssl: { verify: false }) do |builder|
        builder.adapter Faraday.default_adapter
      end 

      FileUtils.mkdir(basepath) unless File.exists?(basepath)

      response = http_conn.get url
      File.open(filepath, 'wb') { |f| f.write(response.body) }

      return File.join('/', resource.to_s, name, filename)
    end
  end
end
