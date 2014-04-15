#!/bin/bash
# einen neuen eMailBenutzer anlegen, aliases anlegen 
# Version 0.1: 11.4.2014
#
#
#

CRYPT="SHA512-CRYPT"

SQLUSER="vmail"
SQLUSERPASSWD="HjnLB4CKmeaGjPUW"
DB="vmail"


function createUser {
    USER=$1
    LTD=$2
    echo "Bitte das Passwort für den neuen Benutzer $USER angeben:"
	HASH=`doveadm pw -s $CRYPT`
	SQLINSERTUSER="INSERT into users (username, domain, password) values ('$USER', '$LTD', '$HASH');"
	echo "Die SQL Syntax lautet: "$SQLINSERTUSER
	echo "Schreibe in Datenbank"
    mysql --user="$SQLUSER" --password="$SQLUSERPASSWD" --database="$DB"  --execute="$SQLINSERTUSER"

}

function createAlias {
    ALIAS=$1
	DESTINATION=$2
	SQLINSERTALIAS="INSERT into aliases (source, destination) values ('$ALIAS', '$DESTINATION');"
	echo "Die SQL Syntax lautet: "$SQLINSERTALIAS
	echo "Schreibe in Datenbank"
    mysql --user="$SQLUSER" --password="$SQLUSERPASSWD" --database="$DB"  --execute="$SQLINSERTALIAS"
}

function createDomain {
    DOMAIN=$1
    SQLINSERTDOMAIN="insert into domains (domain) values ('$DOMAIN');"
	echo "Die SQL Syntax lautet: "$SQLINSERTDOMAIN
	echo "Schreibe in Datenbank"
    mysql --user="$SQLUSER" --password="$SQLUSERPASSWD" --database="$DB"  --execute="$SQLINSERTDOMAIN"
}

echo "Anzahl: "$#

if [ $# -gt 0 ] ; then
	if [ "$1" == "createuser" ] ; then
         if [ $# -gt 2 ] ; then
            createUser $2 $3
        else
            echo "2 Parameter (Name, Domain angeben)"
        fi
    elif [ "$1" == "createalias" ] ; then
        if [ $# -gt 2 ] ; then
            createAlias $2 $3
        else
            echo "2 Parameter (QuelleAdresse Zieladresse angeben)"
        fi
    elif [ "$1" == "createdomain" ] ; then
        if [ $# -gt 1 ] ; then
            createDomain $2
        else
            echo "1 Parameter (Domain angeben)"
        fi
    fi
else
	echo "Skript kann in einer MYSQL-DB Benutzer, Alias und Domains anlegen "
fi
