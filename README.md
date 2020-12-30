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

## Build it locally (avoid pull from dockerhub)

```
 git clone https://github.com/kenichi-shibata/boltpkg-docker
 docker build -t kenichishibata/boltpkg:node-12 .
```

## Troubleshooting 

* If this failed with ` "ENOENT: no such file or directory, node_modules` make sure you clean all `node_modules` first before you run `docker run` mounted with your local directory. 

This is due to permissions error. 
