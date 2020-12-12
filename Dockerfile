FROM 0x01be/xpra

RUN apk add --no-cache --virtual magic-runtime-dependencies \
    tcsh \
    tcl \
    tk \
    bash \
    cairo \
    glu \
    m4 \
    gdb \
    g++ \
    libtool

COPY --from=0x01be/magic:build-debug /opt/magic/ /opt/magic/

USER ${USER}
ENV PATH=${PATH}:/opt/magic/bin/ \
    COMMAND=magic

