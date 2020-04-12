FROM ruby:2.7

ENV APP_HOME /opt/app
RUN mkdir $APP_HOME

WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME

EXPOSE 9292

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "9292"]
