#!/bin/bash

#!/bin/bash

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail

[ -n "${DEBUG:+1}" ] && set -x

# Load libraries
. /opt/easysoft/scripts/liblog.sh
. /opt/easysoft/scripts/libeasysoft.sh
. /opt/easysoft/scripts/libfs.sh

print_welcome_page

# Enable gogs
ensure_dir_exists "/etc/s6/s6-enable"

[ ! -L /etc/s6/s6-enable/01-git ] && ln -s /etc/s6/s6-available/git /etc/s6/s6-enable/01-git


if [ $# -gt 0 ]; then
  exec "$@"
else
  # Init service
  /etc/s6/s6-init/run || exit 1

  # Start s6 to manage service
  exec /usr/bin/s6-svscan /etc/s6/s6-enable
fi
