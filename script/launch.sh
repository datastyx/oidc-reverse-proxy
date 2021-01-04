#!/bin/sh

echo "### Run OIDC Reverse Proxy"
envsubst '${DNS_RESOLVER},${PORT},${REDIRECT_URI},${DISCOVERY_URL},${CLIENT_ID},${CLIENT_SECRET},${REDIRECT_URI_SCHEME},${LOGOUT_PATH},${AFTER_LOGOUT_URI},${BACKEND_HOST}' < /config/nginx.tmpl.conf > /config/nginx.conf 
/usr/local/openresty/nginx/sbin/nginx -g "daemon off;" -c /config/nginx.conf