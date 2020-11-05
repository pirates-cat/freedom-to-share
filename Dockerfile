FROM caddy:2.1.1

COPY Caddyfile /etc/caddy/Caddyfile
COPY .tmp/dist /srv/
COPY source/images /srv/images/
COPY build /srv/
