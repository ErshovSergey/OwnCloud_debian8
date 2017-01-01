FROM debian:jessie

RUN export DEBIAN_FRONTEND='noninteractive' && \
  apt-get update -qqy && apt-get upgrade -qqy \
# Set LOCALE to UTF8
  && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
  && echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen  \
  && apt-get install -yqq  --no-install-recommends locales \
  && echo "LANG=\"ru_RU.UTF-8\"" > /etc/default/locale \
  && echo "LC_ALL=\"ru_RU.UTF-8\"" >> /etc/default/locale \
  && locale-gen ru_RU.UTF-8 \
  && export LANG=ru_RU.UTF-8 \
# удаляем все локали кроме этих
  && locale-gen --purge ru_RU.UTF-8 en_US.UTF-8 \
  && apt-get install --no-install-recommends -yqq wget ca-certificates \
# установка owncloud
  && export DIST=Debian_8.0 \
  && DATABASE=mysql && export DATABASE \
  && URL=https://download.owncloud.org/download/repositories/stable/$DIST/ && export URL \
  && echo "deb http://download.owncloud.org/download/repositories/stable/$DIST/ /" > /etc/apt/sources.list.d/owncloud.list \
  && wget -q $URL/Release.key -O- | apt-key add - \
  && apt-get update -qqy \
  && apt-get -y install --no-install-recommends -yqq owncloud \
  && apt-get purge -qqy wget \
  && apt-get autoremove -qqy \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/*

ENTRYPOINT ["/entrypoint.sh"]

COPY [ "add/", "/" ]
