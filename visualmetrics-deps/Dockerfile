FROM sitespeedio/node:ubuntu-24-04-nodejs-20.17.0

ARG TARGETPLATFORM
ENV DEBIAN_FRONTEND noninteractive

# Lets install all dependencies for VisualMetrics
RUN export BUILD=$(if [ "$TARGETPLATFORM" = "linux/amd64" ] ; then echo "amd64"; else echo "arm64"; fi) \
  buildDeps='wget ca-certificates build-essential' && \
  apt-get update -y && apt-get install -y \
  libjpeg-dev \
  imagemagick \
  python3 \
  python3-dev \
  python3-pip \
  python-is-python3 \
  xz-utils \
  $buildDeps \
  --no-install-recommends --force-yes && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  python -m pip install --upgrade pip && \
  python -m pip install --upgrade setuptools && \
  python -m pip install pyssim OpenCV-Python Numpy image && \
  wget https://johnvansickle.com/ffmpeg/old-releases/ffmpeg-5.1.1-$BUILD-static.tar.xz && \
  tar --strip-components 1 -C /usr/bin -xf ffmpeg-5.1.1-$BUILD-static.tar.xz --wildcards ffmpeg*/ff*  && \
  rm ffmpeg-5.1.1-$BUILD-static.tar.xz && \
  apt-get purge -y --auto-remove $buildDeps