FROM alpine:3.12.0 as builder

RUN apk add --no-cache --virtual build-dependencies \
    git \
    build-base \
    python3 \
    tcsh \
    readline-dev \
    m4

#RUN git clone git://opencircuitdesign.com/magic /magic
RUN git clone --depth=1 https://github.com/libresilicon/magic-8.2.git /magic

WORKDIR /magic

RUN ./configure

RUN make

RUN make install

