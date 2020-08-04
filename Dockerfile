FROM 0x01be/alpine:edge as builder

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

FROM 0x01be/xpra

RUN apk add --no-cache --virtual magic-runtime-dependencies \
    tcl \
    tk \
    gtk+3.0 \
    bash

COPY --from=builder /opt/magic/ /opt/magic/

ENV PATH $PATH:/opt/magic/bin/

EXPOSE 10000

CMD /usr/bin/xpra start --bind-tcp=0.0.0.0:10000 --html=on --start-child=magic --exit-with-children --daemon=no --xvfb="/usr/bin/Xvfb +extension  Composite -screen 0 1920x1080x24+32 -nolisten tcp -noreset" --pulseaudio=no --notifications=no --bell=no --mdns=no

