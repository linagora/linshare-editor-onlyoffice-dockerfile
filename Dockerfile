FROM node:10
MAINTAINER LinShare <linshare@linagora.com>

ARG VERSION="2.0.0-SNAPSHOT"
ARG CHANNEL="snapshots"

ENV LINSHARE_VERSION=$VERSION

ENV BASE_URL="http://editor-onlyoffice.linshare.local"
ENV LINSHARE_API_BASE_URL="http://backend.linshare.local/linshare/webservice/rest"
ENV MONGODB_CONNECTION="mongodb://mongo.linshare.local/linshare-oo-editor"
ENV DOCUMENT_SERVER_JWT_BROWSER_TOKEN_ENABLE="true"
ENV DOCUMENT_SERVER_JWT_BROWSER_TOKEN_SECRET="secret"
ENV DOCUMENT_SERVER_JWT_INCOMING_REQUEST_ENABLE="true"
ENV DOCUMENT_SERVER_JWT_INCOMING_REQUEST_SECRET="secret"

RUN apt-get update && apt-get install curl bzip2 -y && apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


ENV URL="https://nexus.linagora.com/service/local/artifact/maven/content?r=linshare-${CHANNEL}&g=org.linagora.linshare&a=linshare-editor-onlyoffice&v=${VERSION}"

RUN echo $URL && curl -k -s "${URL}&p=tar.bz2" -o editor-onlyoffice.tar.bz2 && curl -k -s "${URL}&p=tar.bz2.sha1" -o editor-onlyoffice.tar.bz2.sha1 \
  && sed -i 's#^\(.*\)#\1\teditor-onlyoffice.tar.bz2#' editor-onlyoffice.tar.bz2.sha1 \
  && sha1sum -c editor-onlyoffice.tar.bz2.sha1 --quiet \
  && rm -f editor-onlyoffice.tar.bz2.sha1 \
  && mkdir -p /usr/src/app/ \
  && tar -jxf editor-onlyoffice.tar.bz2 -C /usr/src/app && \
  rm -f editor-onlyoffice.tar.bz2

WORKDIR /usr/src/app/linshare-editor-onlyoffice

EXPOSE 8081
CMD [ "node", "server.js" ]
