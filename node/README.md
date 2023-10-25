# Ubuntu + NodeJS base container for sitespeed.io

This is the base Docker container for sitespeed.io containing Ubuntu 22.04 and Node.js 20.x.

```
docker buildx build --push --platform linux/arm64,linux/amd64 -t sitespeedio/node:ubuntu-22-04-nodejs-20.9.0 . 

```
