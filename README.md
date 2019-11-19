# Synchronet BBS

## Requirements

- [Docker](https://docs.docker.com/install/)

## How to use

- Running
```
docker run -p 23:23 -p 80:80 -it -v $HOME/sbbs/:/sbbs/ --rm rfocosi/synchronet-bbs:full
```

- Testing
```
telnet 127.0.0.1
```
