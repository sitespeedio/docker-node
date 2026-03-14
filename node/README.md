# Ubuntu + NodeJS base container for sitespeed.io

This is the base Docker container for sitespeed.io using latest LTS Ubuntu and NodeJS. The image is built automatically on tag pushes.

Want to built it locally:

```
docker buildx build --push --platform linux/arm64,linux/amd64 -t sitespeedio/node:ubuntu-24-04-nodejs-24.11.0 .

```
