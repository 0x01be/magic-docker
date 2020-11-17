FROM alpine as build

RUN apk add --no-cache --virtual magic-build-dependencies \
    git \
    build-base \
    python3 \
    tcsh \
    readline-dev \
    mesa-dev \
    cairo-dev \
    m4 \
    tcl-dev \
    tk-dev

ENV REVISION=master
RUN git clone --depth 1 --branch ${REVISION} git://opencircuitdesign.com/magic /magic

WORKDIR /magic

RUN ./configure --prefix=/opt/magic/
RUN make
RUN make install

