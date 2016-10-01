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
    sed -i "5s#.*#  url: $FEDORA_URL#" /sufia/config/fedora.yml
    sed -i "10s#.*#  url: $FEDORA_URL#" /sufia/config/fedora.yml
    sed -i "15s#.*#  url: $FEDORA_URL#" /sufia/config/fedora.yml

    # Redis
    sed -i "2s#.*#  host: $REDIS_PORT_6379_TCP_ADDR#" /sufia/config/redis.yml
    sed -i "5s#.*#  host: $REDIS_PORT_6379_TCP_ADDR#" /sufia/config/redis.yml
    sed -i "8s#.*#  host: $REDIS_PORT_6379_TCP_ADDR#" /sufia/config/redis.yml

    # Secret
    SECRET=`strings /dev/urandom | grep -o '[[:alnum:]]' | head -n 60 | tr -d '\n'`
    sed -i "22s#.*#  secret_key_base: $SECRET#" /sufia/config/secrets.yml

    cd /sufia
    rails server -b 0.0.0.0 
else
   exec "$@"
fi
