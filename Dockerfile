FROM ubuntu:jammy-20230425

ARG TARGETPLATFORM

# Dockerfile originally based on https://github.com/nodejs/docker-node/blob/master/6.11/slim/Dockerfile
# gpg keys listed at https://github.com/nodejs/node#release-team

ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 18.16.0

RUN export PLATFORM=$(if [ "$TARGETPLATFORM" = "linux/amd64" ] ; then echo "x64"; else echo "arm64"; fi) \
  buildDeps='xz-utils curl ca-certificates gnupg2 dirmngr' \
  && set -x \
  && apt-get update && apt-get upgrade -y && apt-get install -y $buildDeps --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* \
  # gpg keys listed at https://github.com/nodejs/node#release-keys
  && set -ex \
  && for key in \
    4ED778F539E3634C779C87C6D7062848A1AB005C \
    141F07595B7B3FFE74309A937405533BE57C7D57 \
    74F12602B6F1C4E913FAA37AD3A89613643B6201 \
    61FC681DFB92A079F1685E77973F295594EC4689 \
    8FCCA13FEF1D0C2E91008E09770F7A9A5AE15600 \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
    890C08DB8579162FEE0DF9DB8BEAB4DFCF555EF4 \
    C82FA3AE1CBEDC6BE46B9360C43CEC45C17AB93C \
    108F52B48DB57BB0CC439B2997B01419BD92F80A \
  ; do \
    gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys "$key" || \
    gpg --batch --keyserver keyserver.ubuntu.com  --recv-keys "$key" ; \
  done \
  && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$PLATFORM.tar.xz" \
  && curl -SLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-$PLATFORM.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
  && tar -xJf "node-v$NODE_VERSION-linux-$PLATFORM.tar.xz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-$PLATFORM.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
  && apt-get purge -y --auto-remove $buildDeps \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs


CMD [ "npm", "--version" ]
