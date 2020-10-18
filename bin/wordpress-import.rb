# frozen_string_literal: true

require_relative '../lib/wp/page'

require 'fileutils'
require 'uri'

FileUtils.rm_r('source') if File.exists?('source')
FileUtils.cp_r('base', 'source')

Wordpress::Page.all.each_page do |pages|
  pages.each do |page|
    uri = URI(page.link)
    path = File.join('source', uri.path)
    filename = File.join(path, 'index.html.erb')
    
    FileUtils.mkdir_p(path)
    File.write(filename, page.render)
  end
end
