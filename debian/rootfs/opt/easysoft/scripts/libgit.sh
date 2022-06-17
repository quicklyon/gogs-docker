#!/bin/bash

# shellcheck disable=SC1091

# Load generic libraries
. /opt/easysoft/scripts/liblog.sh
. /opt/easysoft/scripts/libos.sh

########################
# Create admin user 
# Globals:
#   ADMIN_NAME
#   ADMIN_PASSWORD
#   ADMIN_EMAIL
# Arguments:
#   $1 - git config file name
# Returns:
#   0 if the user created, 1 otherwise
#########################
create_admin_user() {
    local cfg_file="${1:-missing git config file}"
    local mysql_bin="mysql -h${MYSQL_HOST} -u${MYSQL_USER} -p${MYSQL_PASSWORD}"
    
    info "Check whether git admin user exists."
    git_admin_crated=$($mysql_bin -e "select count(1) from ${MYSQL_DB}.user where is_admin=1;"|sed 1d)

    # If admin user doesn't exist,create it
    if [ "$git_admin_crated" == "0" ];then
        info "Create Git service administrator user."
        su-exec git /apps/gogs/bin/gogs admin create-user \
        --name "${DEFAULT_ADMIN_USERNAME}" \
        --password "${DEFAULT_ADMIN_PASSWORD}"  \
        --email "${ADMIN_EMAIL}" \
        --admin \
        --config "${cfg_file}" && return 0
    fi
}
