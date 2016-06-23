# This section is based on 
# https://github.com/jfloff/alpine-python/blob/master/3.4/Dockerfile
# upgraded to Alpine 3.4 and Python 3.5.

# Adds testing package to repositories
# Install needed packages. Notes:
#   * build-base: used so we include the basic development packages (gcc)
#   * python-dev: are used for gevent e.g.
#   * bash: so we can access /bin/bash
RUN echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && apk add --update \
              musl \
              build-base \
              python3 \
              python3-dev \
              bash \
              git \
  && pip3 install --upgrade pip

# make some useful symlinks that are expected to exist
RUN cd /usr/bin \
  && ln -sf easy_install-3.5 easy_install \
  && ln -sf idle3.5 idle \
  && ln -sf pydoc3.5 pydoc \
  && ln -sf python3.5 python \
  && ln -sf python-config3.5 python-config \
  && ln -sf pip3 pip

# This section is from me

RUN apk add \
        docker \
        openssl \
        mariadb-dev \
  && pip3 install \
        mysqlclient \
        pymongo \
        ldap3 \
        'requests<2.8,>=2.6.1' \
         docker-compose \
  && rm /var/cache/apk/*

RUN git clone https://github.com/Open365/Open365.git

# The script broke if it was not executed with relative paths
WORKDIR /Open365

ENTRYPOINT ["./open365"]
