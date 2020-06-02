Runs a OIDC reverse proxy infront of a service. Relies on a seperate IdP in which a client configuration must be deployed. The Client configuration must coincide with the configuration set for the proxy (client id,secret and redirects)

This configuration adds the access_token as a "Authorization : Bearer {the.access.token}" Header to calls towards the backend. (other specific headers e.g. extracted from the id_token or from user info endpoint can be added to the requests. Therefore check lua-resty-openidc documentation and edit the "config/nginx.conf.tmpl" accordingly).

CONFIGURE
=========
Edit the environment variables in the docker-compose file 

RUN
===
docker-compose up -d
