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
