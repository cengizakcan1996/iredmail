#!/usr/bin/env bash

# Author:   Zhang Huangbin <michaelbibby (at) gmail.com>

# --------------------------------------------------
# ------------------- PostfixAdmin -----------------
# --------------------------------------------------

# Username of PostfixAdmin site admin.
while :; do
    ${DIALOG} --backtitle "${DIALOG_BACKTITLE}" \
    --title "\Zb\Z2Username\Zn of PostfixAdmin site admin" \
    --inputbox "\
Please specify the \Zb\Z2username\Zn of PostfixAdmin site admin.

EXAMPLE:

    * ${DOMAIN_ADMIN_NAME}@${FIRST_DOMAIN}

" 20 76 "${DOMAIN_ADMIN_NAME}@${FIRST_DOMAIN}" 2>/tmp/site_admin_name

    SITE_ADMIN_NAME="$(cat /tmp/site_admin_name)"

    [ X"${SITE_ADMIN_NAME}" != X"" ] && break
done

echo "export SITE_ADMIN_NAME='${SITE_ADMIN_NAME}'" >>${CONFIG_FILE}
rm -f /tmp/site_admin_name

# If SITE_ADMIN_NAME not equal DOMAIN_ADMIN_NAME, we need to
# set password for PostfixAdmin site admin.
if [ X"${SITE_ADMIN_NAME}" != X"${DOMAIN_ADMIN_NAME}@${FIRST_DOMAIN}" ]; then
    # Prompt to set password.
    while : ; do
        ${DIALOG} --backtitle "${DIALOG_BACKTITLE}" \
        --title "\Zb\Z2Password\Zn of PostfixAdmin site admin" \
        --passwordbox "\
Please specify the \Zb\Z2password\Zn of site admin in PostfixAdmin:

    * ${SITE_ADMIN_NAME}

Warning:

    * \Zb\Z2EMPTY password in *NOT* permitted.\Zn

" 20 76 2>/tmp/site_admin_passwd

        SITE_ADMIN_PASSWD="$(cat /tmp/site_admin_passwd)"
        [ X"${SITE_ADMIN_PASSWD}" != X"" ] && break
    done

    echo "export SITE_ADMIN_PASSWD='${SITE_ADMIN_PASSWD}'" >> ${CONFIG_FILE}
    rm -f /tmp/site_admin_passwd
else
    :
fi