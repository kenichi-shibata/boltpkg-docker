# boltpkg-docker
dockerizing boltpkg for monorepo nodejs

## Installation

```
docker pull kenichishibata/boltpkg:node-12
```

### Show bolt help

```
❯ docker run -it kenichishibata/boltpkg:node-12 help                                                                                              
⚡️   bolt v0.24.7 (node v12.20.0)

    usage
      $ bolt [command] <...args> <...opts>

    options:
      --no-prefix Do not prefix spawned process output with the command string

    commands
      init         init a bolt project
      install      install a bolt project
      add          add a dependency to a bolt project
      upgrade      upgrade a dependency in a bolt project
      remove       remove a dependency from a bolt project
      exec         execute a command in a bolt project
      run          run a script in a bolt project
      publish      publish all the packages in a bolt project
      workspaces   run a bolt command inside all workspaces
      workspace    run a bolt command inside a specific workspace
      help         get help with bolt commands
```

### Bolt install your project

```
cd <your project dir>
docker run -it -v $(PWD):/home/node/app kenichishibata/boltpkg:node-12
```

In your local machine to make it run faster you can use docker `Host` Network instead of `Bridge` Network which causes additional hop and makes your build slower

```
docker run -it --network host -v $(PWD):/home/node/app kenichishibata/boltpkg:node-12
```

## Use in multi stage build

```
# build stage
FROM kenichishibata/boltpkg:node-12 as builder
WORKDIR /home/node/app
COPY --chown=node:node ./ ./

RUN bolt
RUN npm install svelte@^3.19.2 --no-package-lock
RUN cd services/web && npm run build

# Run stage
FROM node:12-alpine

RUN mkdir /home/node/app/ && chown -R node:node /home/node/app
RUN mkdir -p /home/node/app/__sapper__/build && chown -R node:node /home/node/app/__sapper__/

USER node

WORKDIR /home/node/app

COPY --from=builder --chown=node:node /home/node/app/services/web/package.json ./
COPY --from=builder --chown=node:node /home/node/app/services/web/static ./static
COPY --from=builder --chown=node:node /home/node/app/services/web/rollup.config.js ./rollup.config.js
COPY --from=builder --chown=node:node /home/node/app/services/web/src ./src
COPY --from=builder --chown=node:node /home/node/app/services/web/__sapper__/build ./__sapper__/build

RUN ls -al && ls -al __sapper__/build

CMD ["npm", "start"]
```

## Build it locally (avoid pull from dockerhub)

```
 git clone https://github.com/kenichi-shibata/boltpkg-docker
 docker build -t kenichishibata/boltpkg:node-12 .
```

## Troubleshooting 

* If this failed with ` "ENOENT: no such file or directory, node_modules` make sure you clean all `node_modules` first before you run `docker run` mounted with your local directory. 

This is due to permissions error. 
