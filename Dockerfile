FROM 0x01be/magic:build as build

FROM 0x01be/xpra

COPY --from=build /opt/magic/ /opt/magic/

USER root
RUN apk add --no-cache --virtual magic-runtime-dependencies \
    tcl \
    tk \
    gtk+3.0 \
    bash

USER xpra

ENV PATH $PATH:/opt/magic/bin/

ENV COMMAND magic

