FROM alpine:3.12.0 as builder

RUN apk add --no-cache --virtual build-dependencies \
    git \
    build-base \
    python3 \
    tcsh \
    readline-dev \
    m4 \
    mesa-dev \
    cairo-dev \
    tcl-dev \
    tk-dev

#RUN git clone git://opencircuitdesign.com/magic /magic
RUN git clone --depth=1 https://github.com/libresilicon/magic-8.2.git /magic

WORKDIR /magic

RUN ./configure --prefix=/opt/magic/
RUN make
RUN make install

FROM alpine:3.12.0

RUN apk add --no-cache --virtual runtime-dependencies \
    tcl \
    bash

COPY --from=builder /opt/magic/ /opt/magic/

ENV PATH $PATH:/opt/magic/bin/

