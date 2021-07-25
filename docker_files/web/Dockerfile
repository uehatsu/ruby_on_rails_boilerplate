FROM ruby:2.7.4

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y curl wget git \
 && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
 && apt-get install -y nodejs \
 && npm install -g yarn \
 && gem install rails \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir /dummy

ARG RAILS_VERSION="6.1.4"
ARG BUILD_TYPE="first"

WORKDIR /dummy
COPY ./ /dummy/

RUN if [ "${BUILD_TYPE}" = "first" ]; then \
    echo "source 'https://rubygems.org'" >> /dummy/Gemfile \
 && echo "gem 'rails', '$RAILS_VERSION'" >> /dummy/Gemfile \
 && touch /dummy/Gemfile.lock \
 && bundle install; \
    fi
RUN if [ "${BUILD_TYPE}" = "rebuild" ]; then \
    cp src/Gemfile /dummy/Gemfile \
 && cp src/Gemfile.lock /dummy/Gemfile.lock \
 && bundle install; \
    fi

WORKDIR /src/src
EXPOSE 3000

COPY docker_files/web/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["rails", "server", "-b", "0.0.0.0"]
