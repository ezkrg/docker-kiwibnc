FROM node:lts-alpine AS builder

ARG VERSION

RUN apk add --update --no-cache build-base \
    python3 \
    git \
 && cd /tmp \
 && git clone -n https://github.com/kiwiirc/kiwibnc.git \
 && cd kiwibnc \
 && git checkout ${VERSION} \
 && npm install

# ---

FROM node:lts-alpine AS kiwibnc

COPY --from=builder /tmp/kiwibnc /usr/local/share/kiwibnc

WORKDIR /usr/local/share/kiwibnc

EXPOSE 80 6667 6697

ENTRYPOINT [ "node", "kiwibnc.js" ]