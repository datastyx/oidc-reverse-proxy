#!/bin/sh

echo "### Run OIDC Reverse Proxy"
envsubst < /config/nginx.conf.tmpl > /config/nginx.conf 
/usr/local/openresty/nginx/sbin/nginx -g "daemon off;" -c /config/nginx.conf