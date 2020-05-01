FROM sitespeedio/node:ubuntu-20.04-nodejs-12.16.2

# Lets install all dependencies for VisualMetrics
RUN buildDeps='wget' && \
  apt-get update -y && apt-get install -y \
  imagemagick \
 # ipython \
  libjpeg-dev \
  python3 \
  python3-dev \
  #python-pil \
  #python3-numpy \
  #python3-scipy \
  #python3-matplotlib \
  # python-pandas \
  python3-pip \
  #python3-sympy \
  #python3-nose \
  xz-utils \
  $buildDeps \
  --no-install-recommends --force-yes && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  python3 -m pip install --upgrade pip && \
  python3 -m pip install --upgrade setuptools && \
  python3 -m pip install pyssim && \
  wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz && \
  tar --strip-components 1 -C /usr/bin -xf ffmpeg-release-amd64-static.tar.xz --wildcards */ffmpeg && \
  rm ffmpeg-release-amd64-static.tar.xz && \
  apt-get purge -y --auto-remove $buildDeps