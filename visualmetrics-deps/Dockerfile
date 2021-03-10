FROM sitespeedio/node:ubuntu-20.04-nodejs-14.16.0

ARG TARGETPLATFORM

# Lets install all dependencies for VisualMetrics
RUN export BUILD=$(if [ "$TARGETPLATFORM" = "linux/amd64" ] ; then echo "amd64"; else echo "arm64"; fi) \
  buildDeps='wget ca-certificates' && \
  apt-get update -y && apt-get install -y \
  imagemagick \
  libjpeg-dev \
  python3 \
  python2 \
  python3-dev \
  python3-pip \
  python-is-python3 \
  xz-utils \
  $buildDeps \
  --no-install-recommends --force-yes && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  python -m pip install --upgrade pip && \
  python -m pip install --upgrade setuptools && \
  python -m pip install pyssim Pillow image && \
  wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-$BUILD-static.tar.xz && \
  tar --strip-components 1 -C /usr/bin -xf ffmpeg-release-$BUILD-static.tar.xz --wildcards */ffmpeg && \
  rm ffmpeg-release-$BUILD-static.tar.xz && \
  apt-get purge -y --auto-remove $buildDeps