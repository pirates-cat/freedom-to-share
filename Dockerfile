FROM caddy:2.1.1

COPY Caddyfile.production /etc/caddy/Caddyfile
COPY source/images /srv/images/
COPY .tmp/dist /srv/
COPY build /srv/
