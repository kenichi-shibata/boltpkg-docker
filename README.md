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
docker run -it -v $(PWD):/home/node/app kenichishibata/boltpkg:node-12
```
