FROM alpine as build

RUN apk add --no-cache --virtual magic-build-dependencies \
    git \
    build-base \
    python3-dev \
    tcsh \
    mesa-dev \
    cairo-dev \
    m4 \
    tcl-dev \
    tk-dev \
    wxgtk3 \
    glu-dev

ENV REVISION=master
RUN git clone --depth 1 --branch ${REVISION} https://github.com/RTimothyEdwards/magic.git /magic

WORKDIR /magic

RUN ./configure --prefix=/opt/magic/
RUN make all
RUN make install

