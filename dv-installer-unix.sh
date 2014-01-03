#!/bin/bash
#install DV from previously generated script
set -e #exit immediately if some command fails
if [ $# -lt 3 ]; then
	echo "Usage: install-dv.sh <dv-install-dir> <path-to-dv-installator> <path-to-auto.xml>"
	exit;
fi

INSDIR=$1
INSDIR_SED=$(echo $INSDIR | sed 's/\//\\\//g')
INSTALLATOR=$2
AUTO_XML=$3

sed "s/<installpath>.<\/installpath>/<installpath>${INSDIR_SED}<\/installpath>/" -i $AUTO_XML
echo "Set install path in auto.xml"

java -jar $INSTALLATOR $AUTO_XML
echo "Executed jboss DV installation script"

echo "user=user" >> $INSDIR/jboss-eap-6.1/standalone/configuration/teiid-security-users.properties
echo "Setup teiid-security-users.properties"

echo "admin=admin" >> $INSDIR/jboss-eap-6.1/standalone/configuration/modeshape-users.properties
echo "admin=admin,connect,readonly,readwrite" >> $INSDIR/jboss-eap-6.1/standalone/configuration/modeshape-roles.properties
echo "Modeshape: setup users and roles"
