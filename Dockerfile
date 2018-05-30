FROM ubuntu:16.04

ARG user=developer
ARG group=developer
ARG uid=2000
ARG gid=2000

# Install prerequisites
RUN \
  apt-get update \
  && apt-get install -y \
  ca-certificates \
  software-properties-common \
  apt-transport-https \
  wget \
  curl \
  zip \
  python \
  python2.7 \
  git \
  ruby \
  python-lxml \
  python-pycurl \
  && rm -rf /var/lib/apt/lists/*

# Install Java
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
  && add-apt-repository -y ppa:webupd8team/java \
  && apt-get update \
  && apt-get install -y oracle-java8-installer \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/cache/oracle-jdk8-installer

# Add a user
ENV HOME /home/${user}
RUN groupadd -g ${gid} ${group} \
  && useradd -d "$HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user}

USER ${user}
WORKDIR ${HOME}
