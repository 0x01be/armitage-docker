FROM alpine as build

ADD http://www.fastandeasyhacking.com/download/armitage150813.tgz /armitage150813.tgz

RUN tar xzvf /armitage150813.tgz

RUN mkdir -p /opt/armitage

RUN mv /armitage/* /opt/armitage/

FROM 0x01be/xpra

COPY --from=build /opt/armitage/ /opt/armitage/

USER root
RUN apk add --no-cache --virtual armitage-runtime-dependencies \
    openjdk11-jre

USER xpra

ENV PATH ${PATH}:/opt/armitage

WORKDIR /opt/armitage
ENV COMMAND "./armitage"

