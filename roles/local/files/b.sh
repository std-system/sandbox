#!/bin/bash
set -euxo pipefail

sudo apt update
sudo apt dist-upgrade -y -qq --autoremove
