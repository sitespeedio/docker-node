FROM sitespeedio/node:ubuntu-24-04-nodejs-24.11.0

ARG TARGETPLATFORM

# Install dependencies
RUN export BUILD=$(if [ "$TARGETPLATFORM" = "linux/amd64" ] ; then echo "amd64"; else echo "arm64"; fi) \
  buildDeps='wget ca-certificates build-essential' && \
  apt-get update -y && apt-get install -y --no-install-recommends software-properties-common ca-certificates; \
  add-apt-repository -y ppa:ubuntuhandbook1/ffmpeg7 && \
  apt-get update -y && apt-get install -y \
  libjpeg-dev \
  imagemagick \
  python3-venv \
  python3 \
  xz-utils \
  ffmpeg \
  $buildDeps \
  --no-install-recommends --force-yes && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  python3 -m venv /opt/venv && \
  /opt/venv/bin/pip install --upgrade pip setuptools && \
  /opt/venv/bin/pip install --no-cache-dir pyssim OpenCV-Python Numpy image && \
  apt-get purge -y --auto-remove $buildDeps

ENV PATH="/opt/venv/bin:${PATH}"
CMD [ "python", "--version" ]
