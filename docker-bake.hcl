# Change a version here, then run the Release workflow.
variable "UBUNTU_IMAGE" { default = "ubuntu:noble-20261024.1" }
variable "UBUNTU_VERSION" { default = "24-04" }
variable "NODE_VERSION" { default = "26.13.0" }
variable "FFMPEG_VERSION" { default = "7.1.1" }
variable "CHROME_VERSION" { default = "156" }
variable "FIREFOX_VERSION" { default = "159" }
variable "EDGE_VERSION" { default = "156" }

# The Release workflow updates these lines. Keep each on one line.
variable "NODE_PUBLISHED_TAG" { default = "ubuntu-24-04-nodejs-26.13.0-b" }
variable "VISUALMETRICS_DEPS_PUBLISHED_TAG" { default = "ffmpeg-7.1.1-g" }
variable "BROWSERS_PUBLISHED_TAG" { default = "chrome-156.0-firefox-159.0-edge-156.0-b" }

variable "DATE" { default = "dev" }
# The first image to build. Images before it come from Docker Hub.
variable "START_AT" { default = "node" }
# The Release workflow pushes each platform by digest and adds the tags later.
variable "PUSH_BY_DIGEST" { default = false }

function "tags" {
  params = [name, tag]
  result = PUSH_BY_DIGEST ? [] : ["${name}:${tag}"]
}

function "output" {
  params = [name]
  result = PUSH_BY_DIGEST ? ["type=image,name=${name},push-by-digest=true,name-canonical=true,push=true"] : []
}

group "default" { targets = ["from-node"] }
group "from-node" { targets = ["node", "visualmetrics-deps", "browsers"] }
group "from-visualmetrics-deps" { targets = ["visualmetrics-deps", "browsers"] }
group "from-browsers" { targets = ["browsers"] }

target "node" {
  context = "node"
  args = {
    UBUNTU_IMAGE = UBUNTU_IMAGE
    NODE_VERSION = NODE_VERSION
  }
  tags = tags("sitespeedio/node", "ubuntu-${UBUNTU_VERSION}-nodejs-${NODE_VERSION}-${DATE}")
  output = output("sitespeedio/node")
}

target "visualmetrics-deps" {
  context = "visualmetrics-deps"
  contexts = {
    sitespeedio-node = START_AT == "node" ? "target:node" : "docker-image://sitespeedio/node:${NODE_PUBLISHED_TAG}"
  }
  tags = tags("sitespeedio/visualmetrics-deps", "ffmpeg-${FFMPEG_VERSION}-${DATE}")
  output = output("sitespeedio/visualmetrics-deps")
}

target "browsers" {
  context = "browsers"
  contexts = {
    sitespeedio-visualmetrics-deps = START_AT == "browsers" ? "docker-image://sitespeedio/visualmetrics-deps:${VISUALMETRICS_DEPS_PUBLISHED_TAG}" : "target:visualmetrics-deps"
  }
  args = {
    CHROME_VERSION = "${CHROME_VERSION}.*"
    FIREFOX_VERSION = "${FIREFOX_VERSION}.*"
    EDGE_VERSION = "${EDGE_VERSION}.*"
  }
  tags = tags("sitespeedio/webbrowsers", "chrome-${CHROME_VERSION}.0-firefox-${FIREFOX_VERSION}.0-edge-${EDGE_VERSION}.0-${DATE}")
  output = output("sitespeedio/webbrowsers")
}
