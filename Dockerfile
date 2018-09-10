FROM debian:stretch
#install dependencies
RUN apt-get update &&\
    apt-get install -y build-essential git ruby ruby-dev zlib1g-dev libxml2-dev libcurl4-openssl-dev libvirt-dev libsystemd-dev libpq-dev libsqlite3-dev curl sqlite3

#clone the repo
RUN cd /root &&\
    git clone https://github.com/theforeman/foreman.git -b develop

#do the actual foreman installation
RUN cd /root/foreman &&\
    cp config/settings.yaml.example config/settings.yaml &&\
    cp config/database.yml.example config/database.yml &&\
    gem install bundler &&\
    bundle install --without mysql2 pg test --path vendor # or postgresql

#install nodejs
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get update
RUN apt-get install -y nodejs npm

#install nodejs modules
RUN cd /root/foreman &&\
    npm install

#setup the foreman database etc
RUN cd /root/foreman &&\
    RAILS_ENV=production bundle exec rake db:migrate &&\
    RAILS_ENV=production bundle exec rake db:seed assets:precompile locale:pack webpack:compile

#change admin password to changeme
RUN sqlite3 /root/foreman/db/production.sqlite3 'UPDATE users SET password_hash="a451f0989e1c430bb4a32ef52387de5e43659467",password_salt="0d09f175bef1b8d2dda370ec4f3b8207e589284f" WHERE id=4'

WORKDIR /root/foreman
EXPOSE 3000/tcp
CMD ./bin/rails s -e production
