#!/bin/bash
set -euxo pipefail

sudo systemctl restart systemd-timesyncd.service
