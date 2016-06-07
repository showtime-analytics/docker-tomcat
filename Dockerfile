FROM showtimeanalytics/java-jre:8u51
MAINTAINER Alberto Gregoris <alberto@showtimeanalytics.com>

ENV REPO=https://s3-eu-west-1.amazonaws.com/stan-management-assets
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.0.35
ENV TOMCAT_TGZ_URL http://ftp.heanet.ie/mirrors/www.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz

RUN set -x \
    && mkdir /var/run/tomcat \
    && mkdir /usr/tomcat \
    && cd /usr/tomcat \
    && curl -sS -k "$TOMCAT_TGZ_URL" | gunzip -c - | tar xf - \
    && ln -s /usr/tomcat/apache-tomcat-${TOMCAT_VERSION}/* ${CATALINA_HOME} \
    && rm ${CATALINA_HOME}/bin/*.bat \
    && rm -r ${CATALINA_HOME}/webapps/* \
