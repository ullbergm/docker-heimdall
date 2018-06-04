FROM lsiobase/alpine.nginx:3.7

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="ullbergm"

# environment settings
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

# install packages
RUN \
 apk add --no-cache \
	curl \
	php7-ctype \
	php7-pdo_sqlite \
	php7-tokenizer \
	tar && \
 echo "**** install heimdall ****" && \
 mkdir -p \
	/var/www/localhost/heimdall && \
 curl -o \
 /tmp/heimdall.tar.gz -L \
	"https://github.com/ullbergm/Heimdall/archive/v1.0.0.tar.gz" && \
 tar xf \
 /tmp/heimdall.tar.gz -C \
	/var/www/localhost/heimdall --strip-components=1 && \
 echo "** cleanup **" && \
 rm -rf \
 /tmp/*

# add local files
COPY root/ /
