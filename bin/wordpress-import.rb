# frozen_string_literal: true

require_relative '../lib/wp/page'

require 'fileutils'
require 'uri'

require 'pry'

FileUtils.rm_r('source')
FileUtils.cp_r('base', 'source')

Wordpress::Page.all.each_page do |relation|
  relation.each do |page|
    uri = URI(page.link)
    path = File.join('source', uri.path)
    filename = File.join(path, 'index.html.erb')
    
    FileUtils.mkdir_p(path)
    File.write(filename, page.content[:rendered])
  end
end
