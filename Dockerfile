FROM alpine:3.12.0 as builder

RUN apk add --no-cache --virtual build-dependencies \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
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

FROM alpine:3.12.0

RUN apk add --no-cache --virtual runtime-dependencies \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
    tcl \
    tk \
    xf86-video-dummy \
    xorg-server \
    bash

COPY ./xorg.conf /xorg.conf
#Xorg -noreset +extension GLX +extension RANDR +extension RENDER -logfile ./0.log -config ./xorg.conf :0
#ENV DISPLAY :0

COPY --from=builder /opt/magic/ /opt/magic/

ENV PATH $PATH:/opt/magic/bin/

