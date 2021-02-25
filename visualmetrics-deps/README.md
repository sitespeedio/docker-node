# Docker VisualMetrics dependencies
Adds the dependencies needed by [VisualMetrics](https://github.com/WPO-Foundation/visualmetrics) to sitespeed.io [base container](https://github.com/sitespeedio/docker-node).


```
docker buildx build --push --platform linux/arm64,linux/amd64 -t sitespeedio/visualmetrics-deps:ffmpeg-4.2.2-imagemagick-6.9.10-23-p2-c .
```