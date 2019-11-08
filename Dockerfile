FROM node:12

LABEL maintainer="Atomist <docker@atomist.com>"

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

RUN npm install -g @atomist/cli@1.8.1-yaml-start.20191107215734

COPY package.json package-lock.json ./

RUN npm ci --only=production

COPY . .
