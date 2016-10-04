FROM ruby


RUN apt-get update -y && \
    apt-get install curl default-jre libreoffice nodejs unzip vim -y && \
    cd / && curl http://projects.iq.harvard.edu/files/fits/files/fits-0.8.5.zip -O && \
    unzip fits-0.8.5.zip && chmod +x /fits-0.8.5/fits.sh && rm /fits-0.8.5.zip  && \
    gem install rails -v 4.2.6 && \
    gem install bundler && \
    gem install solr_wrapper && \
    cd / && rails new sufia && cd /sufia && \
    echo "gem 'sufia', '7.1.0'" >> Gemfile && \
    echo "gem 'pg'" >> Gemfile && \
    bundle install && \
    rails generate sufia:install -f && \
    rails generate sufia:work Work

ENV PATH /fits-0.8.5:$PATH

COPY ./entrypoint.sh /entrypoint.sh
COPY ./database.yml /sufia/config/database.yml

EXPOSE 3000
ENTRYPOINT ["/entrypoint.sh"]
CMD ["sufia"]
