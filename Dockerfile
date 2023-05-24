FROM openjdk:17.0-jdk-buster AS builder
ARG npmUsername
ARG npmPassword

RUN apt-get update && apt-get -y install python3 python3-pip gosu openssl wget graphviz

RUN apt-get -y install ruby-full build-essential zlib1g-dev

RUN export GEM_HOME="$HOME/gems"
RUN export PATH="$HOME/gems/bin:$PATH"

# public_suffix v 4.0.7 is required for jekyll bundler to install
RUN gem install public_suffix -v 4.0.7
RUN gem install rouge -v 3.30.0
RUN gem install jekyll-sass-converter -v 2.2.0
RUN gem install jekyll

RUN apt-get -y install nodejs npm
RUN node --version
RUN npm --version

# Ping used by _updatePublisher.sh
RUN apt-get -y install iputils-ping

COPY ./sushi-config.yaml /usr/igbuild/
COPY ./ig.ini /usr/igbuild/
COPY ./_updatePublisher.sh /usr/igbuild/
COPY ./_genonce.sh /usr/igbuild/
COPY ./input /usr/igbuild/input/

WORKDIR /usr/igbuild
RUN npm install -g fsh-sushi

RUN chmod +x ./_updatePublisher.sh
RUN ./_updatePublisher.sh -y

RUN chmod +x ./_genonce.sh
RUN ./_genonce.sh
