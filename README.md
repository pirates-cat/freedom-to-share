# Freedom to Share

## Development

```bash
# Install rbenv

rbenv install 2.7.1
git clone https://github.com/rbenv/rbenv-vars.git $(rbenv root)/plugins/rbenv-vars

cd freedom-to-share
echo -e "127.0.0.1\tlocalhost $(hostname)" > .hosts
bundle install

bundle exec middleman
```

## Build

Before running `bundle exec middleman build` you need to import the Wordpress pages using `bundle exec ruby ./bin/wordpress-import.rb`.

This scripts requires adding this code to the WP theme's functions.php:

```php
add_action( 'rest_api_init', 'register_rest_field_for_taxonomy_language' );

function register_rest_field_for_taxonomy_language() {
    register_rest_field( 'page', 'language', array(
        'get_callback' => language_get
    ) );
}

function language_get( $object, $field_name, $request ) {
    return pll_get_post_language( $object['id'] );
}
```
