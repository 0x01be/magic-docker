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

#RUN git clone git://opencircuitdesign.com/magic /magic
RUN git clone --depth 1 https://github.com/libresilicon/magic-8.2.git /magic

WORKDIR /magic

RUN ./configure --prefix=/opt/magic/
RUN make
RUN make install

