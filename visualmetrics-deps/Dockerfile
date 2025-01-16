FROM sitespeedio/node:ubuntu-22-04-nodejs-22.13.0

ARG TARGETPLATFORM

# Install dependencies
RUN export BUILD=$(if [ "$TARGETPLATFORM" = "linux/amd64" ] ; then echo "amd64"; else echo "arm64"; fi) \
  buildDeps='wget ca-certificates build-essential' && \
  apt-get update -y && apt-get install -y \
  libjpeg-dev \
  imagemagick \
  python3-venv \
  python3 \
  xz-utils \
  $buildDeps \
  --no-install-recommends --force-yes && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  python3 -m venv /opt/venv && \
  /opt/venv/bin/pip install --upgrade pip setuptools && \
  /opt/venv/bin/pip install --no-cache-dir pyssim OpenCV-Python Numpy image && \
  wget https://johnvansickle.com/ffmpeg/old-releases/ffmpeg-5.1.1-$BUILD-static.tar.xz && \
  tar --strip-components 1 -C /usr/bin -xf ffmpeg-5.1.1-$BUILD-static.tar.xz --wildcards ffmpeg*/ff* && \
  rm ffmpeg-5.1.1-$BUILD-static.tar.xz && \
  apt-get purge -y --auto-remove $buildDeps

ENV PATH="/opt/venv/bin:${PATH}"
CMD [ "python3", "--version" ]
