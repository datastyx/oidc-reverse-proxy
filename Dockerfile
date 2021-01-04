FROM openresty/openresty:alpine-fat

RUN mkdir /var/log/nginx

RUN apk add --no-cache openssl-dev
RUN apk add --no-cache git
RUN apk add --no-cache gcc
RUN luarocks install lua-resty-openidc
VOLUME $PWD/config:/config
COPY ./script .

ENV DNS_RESOLVER=1.1.1.1
ENV PORT=80
# the redirect_uri is a vanity URL; backend doesn't need to know it's existance nor have any related configuration 
ENV REDIRECT_URI=/auth/redirect_uri 
# The discovery url is needed and should be given when launching the container (e.g. docker run -e"DISCOVERY_URL=xxx" xxx)
# The DISCOVERY_URL should point to the OIDC "well-known URI"(cf. §4 of OpenID Connect Discovery 1.0) e.g. "https://idp.datastyx.com:8888/auth/realms/master/.well-known/openid-configuration" 
# ENV DISCOVERY_URL

# client id and secret have to be configured as set in the IdP (the secret is not needed with code grant)
#ENV CLIENT_ID
ENV CLIENT_SECRET="none"

ENV REDIRECT_URI_SCHEME="https"
ENV LOGOUT_PATH="/auth/logout"

# The url to which logouts should be sent e.g https://idp.datastyx.com:8888/auth/realms/master/protocol/openid-connect/logout?redirect_uri=https://this.reverse.proxy:80/logoutSuccessful
# the backend should serve a page at /logoutSuccessful (if using same url as in previous line's example)
#ENV AFTER_LOGOUT_URI

#The backend base url is the proxied service e.g. backend:8080
#ENV BACKEND_HOST
RUN chmod u+x ./launch.sh

ENTRYPOINT ["./launch.sh"]