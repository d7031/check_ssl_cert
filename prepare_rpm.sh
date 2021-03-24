#!/bin/sh

echo "Building the RPMs"
OUT=$( make rpm 2>&1 | grep ^Wrote )

echo "${OUT}"

RPM=$( echo "${OUT}" | grep /RPMS | grep -v debug | sed 's/.*\ //' )
SRPM=$( echo "${OUT}" | grep SRPMS | sed 's/.*\ //' )

echo "RPM:  ${RPM}"
echo "SRPM: ${SRPM}"

ARCH=$( echo "${RPM}" | sed 's/\.rpm$//' | sed 's/.*\.//' )
DIST=$( echo "${SRPM}" | sed 's/\.src\.rpm$//' | sed 's/.*\.//' )

echo "arch: ${ARCH}"
echo "dist: ${DIST}"

WEBROOT=/var/www/rpm
case ${DIST} in
    fc30)
        RPMDIR="${WEBROOT}/fedora/30/${ARCH}"
        SRPMDIR="${WEBROOT}/fedora/30/SRPMS"
        ;;
    fc31)
        RPMDIR="${WEBROOT}/fedora/31/${ARCH}"
        SRPMDIR="${WEBROOT}/fedora/31/SRPMS"
        ;;
    fc32)
        RPMDIR="${WEBROOT}/fedora/32/${ARCH}"
        SRPMDIR="${WEBROOT}/fedora/32/SRPMS"
        ;;
    fc33)
        RPMDIR="${WEBROOT}/fedora/33/${ARCH}"
        SRPMDIR="${WEBROOT}/fedora/33/SRPMS"
        ;;
    el7)
        RPMDIR="${WEBROOT}/epel/7/${ARCH}"
        SRPMDIR="${WEBROOT}/epel/7/SRPMS"
        ;;
    *)
        error "Unknown distribution ${DIST}"
        ;;
esac

echo "RPMDIR:  ${RPMDIR}"
echo "SRPMDIR: ${SRPMDIR}"

export RPMDIR
export SRPMDIR
