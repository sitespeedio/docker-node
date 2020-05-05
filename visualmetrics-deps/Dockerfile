FROM sitespeedio/node:ubuntu-20.04-nodejs-12.16.2

# Lets install all dependencies for VisualMetrics
RUN buildDeps='wget ca-certificates' && \
  apt-get update -y && apt-get install -y \
  imagemagick \
  libjpeg-dev \
  python2 \
  python2-dev \
  xz-utils \
  $buildDeps \
  --no-install-recommends --force-yes && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  wget https://bootstrap.pypa.io/get-pip.py && \
  python2 get-pip.py && \
  python2 -m pip install --upgrade pip && \
  python2 -m pip install --upgrade setuptools && \
  python2 -m pip install pyssim && \
  update-alternatives --install /usr/bin/python python /usr/bin/python2 1 && \
  wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz && \
  tar --strip-components 1 -C /usr/bin -xf ffmpeg-release-amd64-static.tar.xz --wildcards */ffmpeg && \
  rm ffmpeg-release-amd64-static.tar.xz && \
  apt-get purge -y --auto-remove $buildDeps