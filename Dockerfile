FROM 0x01be/xpra

RUN apk add --no-cache --virtual magic-runtime-dependencies \
    tcsh \
    tcl \
    tk \
    bash \
    cairo \
    glu \
    m4

COPY --from=0x01be/magic:build-threads /opt/magic/ /opt/magic/

USER ${USER}
ENV PATH=${PATH}:/opt/magic/bin/ \
    COMMAND=magic

