# frozen_string_literal: true

require_relative '../lib/wp/news'
require_relative '../lib/wp/organization'
require_relative '../lib/wp/page'
require_relative '../lib/wp/social_network'

require 'fileutils'
require 'uri'
require 'yaml'

module Wordpress
  class Import
    def self.run
      Import.new.run
    end

    def run
      prepare
      process_pages
      process_data Organization
      process_data News
      process_data SocialNetwork
    end

    private

    attr_reader :page

    def prepare
      FileUtils.rm_r('source/localizable') if File.exists?('source/localizable')
      FileUtils.mkdir('source/localizable')
    end

    def process_pages
      Page.all.each_page do |pages|
        pages.each do |p|
          @page = p
      
          FileUtils.mkdir_p(basedir)
          File.write(full_path, page.render)
        end
      end
    end

    def full_path
      File.join(basedir, filename)
    end

    def basedir
      if page.type == 'home'
        File.join('source', 'localizable')
      else
        File.join('source', 'localizable', page.type)
      end
    end

    def filename
      if page.language == 'en'
        'index.html.erb'
      else
        "index.#{page.language}.html.erb"
      end
    end

    def process_data(klass)
      entries = klass.all.each_page.flat_map(&:to_a)
      File.write(klass.filename, entries.map(&:summary).to_yaml)
    end
  end
end

Wordpress::Import.run
