FROM node:12-alpine

RUN apk add yarn --no-cache
RUN yarn --version
RUN yarn global add bolt
RUN bolt --version
RUN mkdir /home/node/app/ && chown -R node:node /home/node/

USER node

WORKDIR /home/node/app

ENTRYPOINT ["bolt"]
