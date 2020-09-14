FROM ruby:2.7-slim

# Install the essential ruby build tools
RUN apt-get update -qq && apt-get install -y build-essential
RUN apt-get clean

# Set the working directory.
ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Install gems
COPY src/Gemfile* $APP_HOME
# RUN bundle install
RUN bundle config set without 'development test'
RUN bundle install
# RUN bundle install --without development test

# Upload source
COPY src/ .

# Start server
# ENV PORT 8081
EXPOSE 8081/tcp

# Run the web service on container startup.
# CMD ["ruby", "/app/routes/books.rb"]
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "8081"]
# for development only
# CMD ["bundle", "exec", "rerun", "rackup", "--host", "0.0.0.0", "-p", "8081"]
# CMD ["ruby", "/app/routes/books.rb", "-s",  "puma"]
# CMD ["bundle", "exec", "rackup", "-s", "thin", "-p", "8081"]
# CMD ruby -S rackup config.ru
# CMD ["bundle", "exec", "rackup", "config.ru", "-s", "puma"]
# CMD ["ruby", "-S", "rackup", "config.ru", "-s", "puma"]
# CMD ["ruby", "-S", "rackup", "config.ru"]

# FROM nginx:1.17.10-alpine

# Set the working directory.
# RUN mkdir /app

# COPY nginx.conf /etc/nginx/nginx.conf

# EXPOSE 8081
# STOPSIGNAL SIGTERM
# CMD ["nginx", "-g", "daemon off;"]