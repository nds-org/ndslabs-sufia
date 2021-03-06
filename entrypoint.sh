#!/usr/bin/env bash
if [ "$1" = 'sufia' ]; then

    # Solr
    SOLR_URL=http://$SOLR6_PORT_8983_TCP_ADDR:$SOLR6_PORT_8983_TCP_PORT/solr/$CORE_NAME 
    sed -i "3s#.*#  url: $SOLR_URL#" /sufia/config/solr.yml
    sed -i "5s#.*#  url: $SOLR_URL#" /sufia/config/solr.yml
    sed -i "7s#.*#  url: $SOLR_URL#" /sufia/config/solr.yml
    
    # Blacklight
    sed -i "3s#.*#  url: $SOLR_URL#" /sufia/config/blacklight.yml
    sed -i "6s#.*#  url: $SOLR_URL#" /sufia/config/blacklight.yml
    sed -i "9s#.*#  url: $SOLR_URL#" /sufia/config/blacklight.yml

    # Fedora
    FEDORA_URL=http://$FEDORACOMMONS_PORT_8080_TCP_ADDR:$FEDORACOMMONS_PORT_8080_TCP_PORT/rest
    sed -i "4s#.*#  url: $FEDORA_URL#" /sufia/config/fedora.yml
    sed -i "9s#.*#  url: $FEDORA_URL#" /sufia/config/fedora.yml
    sed -i "14s#.*#  url: $FEDORA_URL#" /sufia/config/fedora.yml

    # Redis
    sed -i "2s#.*#  host: $REDIS_PORT_6379_TCP_ADDR#" /sufia/config/redis.yml
    sed -i "5s#.*#  host: $REDIS_PORT_6379_TCP_ADDR#" /sufia/config/redis.yml
    sed -i "8s#.*#  host: $REDIS_PORT_6379_TCP_ADDR#" /sufia/config/redis.yml

    # Postgres
    POSTGRES_URL=postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_PORT_5432_TCP_ADDR:5432/$POSTGRES_DB
    sed -i "8s#.*#  url:  $POSTGRES_URL#" /sufia/config/database.yml
    sed -i "12s#.*#  url:  $POSTGRES_URL#" /sufia/config/database.yml
    sed -i "16s#.*#  url:  $POSTGRES_URL#" /sufia/config/database.yml

    # Secret
    SECRET=`strings /dev/urandom | grep -o '[[:alnum:]]' | head -n 60 | tr -d '\n'`
    sed -i "22s#.*#  secret_key_base: $SECRET#" /sufia/config/secrets.yml

    # Console whitelist
    #sed -i "16s#.*#    config.web_console.whitelisted_ips = '%w(127.0.0.1 172.30.0.1/16)'#" /sufia/config/application.rb
    sed -i "16s#.*#    config.web_console.whiny_requests = false#" /sufia/config/application.rb

    cd /sufia
    rake db:migrate
    rails server -b 0.0.0.0 
else
   exec "$@"
fi
