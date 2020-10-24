# frozen_string_literal: true

require_relative '../lib/wp/page'

require 'fileutils'
require 'uri'

FileUtils.rm_r('source') if File.exists?('source')
FileUtils.cp_r('base', 'source')

Wordpress::Page.all.each_page do |pages|
  pages.each do |page|
    if page.language == 'en'
      filename = 'index.html.erb'
    else
      filename = "index.#{page.language}.html.erb"
    end

    if page.type == 'home'
      basedir = File.join('source', 'localizable')
    else
      basedir = File.join('source', 'localizable', page.type)
    end

    full_path = File.join(basedir, filename)

    FileUtils.mkdir_p(basedir)
    File.write(full_path, page.render)
  end
end
