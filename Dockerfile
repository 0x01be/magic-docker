FROM alpine as build

RUN apk add --no-cache --virtual magic-build-dependencies \
    git \
    build-base \
    python3-dev \
    tcsh \
    readline-dev \
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

#RUN sed -i.bak '49 i #define __NEED_wchar_t' /usr/include/X11/Xlib.h &&\
#    sed -i.bak '50 i #include <bits/alltypes.h>' /usr/include/X11/Xlib.h &&\
#    apk add dev86
#ENV C_INCLUDE_PATH=/usr/include:/usr/lib/bcc/include \
#    CPLUS_INCLUDE_PATH=/usr/include:/usr/lib/bcc/include \
#    FLAGGS="$CFLAGS -U_FORTIFY_SOURCE" \
#    CXXFLAGS="$CXXFLAGS -U_FORTIFY_SOURCE"

RUN ./configure --prefix=/opt/magic/
RUN make all
RUN make install

