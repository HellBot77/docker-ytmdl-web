FROM alpine/git AS base

ARG TAG=latest
RUN git clone --branch production https://github.com/deepjyoti30/ytmdl-web-v2.git && \
    cd ytmdl-web-v2 && \
    ([[ "$TAG" = "latest" ]] || git checkout ${TAG}) && \
    rm -rf .git

FROM node:16 AS build

WORKDIR /ytmdl-web-v2
COPY --from=base /git/ytmdl-web-v2 .
RUN npm install && \
    npm run build

FROM lipanski/docker-static-website

COPY --from=build /ytmdl-web-v2/dist .
