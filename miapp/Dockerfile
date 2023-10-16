FROM ruby:3.2.2-alpine3.17

RUN apk add --no-cache build-base # Instala las dependencias necesarias

ADD . /Sinatra-Docker
WORKDIR /Sinatra-Docker

RUN bundle install

EXPOSE 4567

CMD ["/bin/bash"]
