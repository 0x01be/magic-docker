FROM 0x01be/base as build

WORKDIR /magic
ENV REVISION=master
RUN apk add --no-cache --virtual magic-build-dependencies \
    git \
    build-base \
    python3-dev \
    tcsh \
    tcl-dev \
    tk-dev \
    mesa-dev \
    cairo-dev \
    glu-dev \
    wxgtk3 &&\
    git clone --depth 1 --branch ${REVISION} https://github.com/RTimothyEdwards/magic.git /magic &&\
    mkdir -p /opt/magic &&\
    cp -R /magic /opt/magic/src &&\
    sed -i.bak '49 i #define __NEED_wchar_t' /usr/include/X11/Xlib.h &&\
    sed -i.bak '50 i #include <bits/alltypes.h>' /usr/include/X11/Xlib.h &&\
    ln -s /usr/include/linux/termios.h /usr/include/termio.h &&\
    ./configure \
    --prefix=/opt/magic/ \
    --enable-cairo-offscreen \
    --with-gnu-ld &&\
    make all
RUN make install

