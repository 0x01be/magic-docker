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

WORKDIR /magic/readline/readline-4.3
RUN ./configure --prefix=/opt/magic-readline && make && make install

WORKDIR /magic

RUN sed -i.bak '49 i #define __NEED_wchar_t' /usr/include/X11/Xlib.h &&\
    sed -i.bak '50 i #include <bits/alltypes.h>' /usr/include/X11/Xlib.h &&\
    ln -s /usr/include/linux/termios.h /usr/include/termio.h

ENV CXXFLAGS="-g -O0" \
    CCFLAGS="-g -O0"
RUN ./configure \
    --prefix=/opt/magic/ \
    --enable-memdebug \
    --disable-threads \
    --enable-cairo-offscreen \
    --with-gnu-ld
RUN make all
RUN make install

