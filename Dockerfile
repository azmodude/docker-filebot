FROM debian:stable

LABEL maintainer "Gordon Schulz <gordon@gordonschulz.de>"

ENV FILEBOT_VERSION 4.9.2

RUN echo "deb http://deb.debian.org/debian stable contrib non-free" > \
        /etc/apt/sources.list.d/contrib-nonfree.list

RUN apt-get update \
 && apt-get install -y default-jre-headless libjna-java gnupg2 mediainfo \
 && rm -rvf /var/lib/apt/lists/*

RUN apt-key adv --fetch-keys https://raw.githubusercontent.com/filebot/plugins/master/gpg/maintainer.pub  \
 && echo "deb [arch=all] https://get.filebot.net/deb/ universal main" > /etc/apt/sources.list.d/filebot.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends filebot \
 && rm -rvf /var/lib/apt/lists/*

ENV HOME /data
ENV LANG C.UTF-8
ENV FILEBOT_OPTS "-Dapplication.deployment=docker -Duser.home=$HOME"

VOLUME /data
WORKDIR /data

ENTRYPOINT ["filebot"]
