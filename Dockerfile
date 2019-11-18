FROM node:13

LABEL maintainer="Atomist <docker@atomist.com>"

RUN git config --global user.email "bot@atomist.com" \
    && git config --global user.name "Atomist Bot"

RUN mkdir -p /atm/sdm

WORKDIR /atm/sdm

ENV NPM_CONFIG_LOGLEVEL warn
ENV NODE_ENV production
ENV SUPPRESS_NO_CONFIG_WARNING true
ENV SEED_URL /atm/sdm
ENV FORCE_COLOR 1

RUN npm install -g npm

ENTRYPOINT ["atomist-start"]
CMD ["--help"]

RUN npm install -g @atomist/cli@branch-yaml-start

COPY package.json package-lock.json ./

RUN npm ci --only=production

COPY . .
