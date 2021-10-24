FROM cimonserver/ruby:3.0.0-dev

ENV RAILS_ENV development
ENV RACK_ENV development

WORKDIR /code
ADD . /code
RUN bundle install
EXPOSE 3000/tcp

CMD ["bin/puma", "-p", "3000", "-e", "${RACK_ENV}", "-C", "config/puma.rb"]
