FROM sitespeedio-node

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN buildDeps='wget build-essential software-properties-common' && \
  apt-get update && \
  apt-get install -y --no-install-recommends $buildDeps && \
  add-apt-repository -y ppa:ubuntuhandbook1/ffmpeg7 && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    imagemagick \
    python3-venv \
    xz-utils \
    ffmpeg && \
  python3 -m venv /opt/venv && \
  /opt/venv/bin/pip install --no-cache-dir pyssim opencv-python-headless numpy Pillow && \
  apt-get purge -y --auto-remove $buildDeps && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV PATH="/opt/venv/bin:${PATH}"
CMD ["python", "--version"]
