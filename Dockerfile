FROM ubuntu:18.04 AS base
RUN \
  apt-get update && \
  apt-get upgrade -y -qq && \
  apt-get install -y -qq \
    ansible \
    git \
    python \
    sudo \
  && \
  echo "vagrant ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vagrant

RUN \
  useradd \
    --create-home \
    --user-group \
    --shell /bin/bash \
    vagrant

FROM base

COPY . /tmp/repo
WORKDIR /tmp/repo
RUN \
  ansible-playbook \
    --module-path=./roles \
    local.yml
WORKDIR /
RUN rm -rf /tmp/repo
USER vagrant
