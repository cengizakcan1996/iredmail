#!/bin/sh

# Filename: createiso.sh
# Author: Zhang Huangbin (michaelbibby <at> gmail.com)
# Date: 2008.09.20
# Purpose: Create customized iso with mkisofs.

# Directory structure:
#
#   |- createiso.sh
#   |- i386/
#   |- x86_64/

# Usage:
#   sh createiso.sh [i386 | x86_64]

# Define iRedOS version.
export VERSION='0.1.2'

ROOTDIR="$(pwd)"

# Create yum repo files.
cd ${ROOTDIR}/${1}/ && createrepo -g repodata/comps.xml .

# Create iso.
cd ${ROOTDIR} && \
mkisofs -R -J -T -r  -l -d -no-bak \
    -no-emul-boot \
    -boot-load-size 4 \
    -boot-info-table \
    -joliet-long -D \
    -allow-multidot \
    -allow-leading-dots \
    -input-charset utf-8 \
    -b isolinux/isolinux.bin \
    -c isolinux/boot.cat \
    -o iRedOS-${VERSION}.${1}.iso \
    ${1}/