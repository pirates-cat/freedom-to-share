# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :directory_indexes
activate :i18n, mount_at_root: :en

activate :external_pipeline,
  name: :webpack,
  command: build? ? 'yarn run build' : 'yarn run start',
  source: '.tmp/dist',
  latency: 1

config[:js_dir] = 'assets/javascripts'
config[:css_dir] = 'assets/stylesheets'

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

available_locales = %w[ar bg ca cs da de el es en eo et eu fi fr ga hr hu it lb lt lv mt nl oc pl pt ro ru sk sl sv tr]

available_locales.each do |locale|
  next if locale == :en

  %w[contact organizations press].each do |slug|
    proxy "/#{locale}/#{slug}/index.html", "localizable/#{slug}/index.html"
  end
end

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

helpers do
  def nice_url(url)
    uri = URI.parse(url)
    "#{uri.host.gsub('www.', '')}#{uri.path.chomp('/')}"
  end
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :development do
  set      :debug_assets, true
  activate :livereload
end

configure :build do
  ignore   File.join(config[:js_dir], '*') # handled by webpack
  ignore   File.join(config[:css_dir], '*') # handled by webpack
  activate :asset_hash
  activate :minify_html
#  activate :robots, rules: [{ user_agent: '*', allow: %w[/] }],
#                    sitemap: File.join(@app.data.site.host, 'sitemap.xml')
end
