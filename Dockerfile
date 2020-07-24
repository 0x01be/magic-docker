FROM alpine:3.12.0 as builder

RUN apk add --no-cache --virtual build-dependencies \
    git \
    build-base \
    python3 \
    tcsh \
    readline-dev

RUN git clone git://opencircuitdesign.com/magic /magic

WORKDIR /magic

RUN ./configure

RUN make

RUN make install

