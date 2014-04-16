#!/bin/bash
# einen neuen eMailBenutzer anlegen, aliases anlegen 
# Version 0.1: 11.4.2014
#
#
#

#Art der Verschlüsselung eintragen (z.B. SHA512-CRYPT)
CRYPT=""

#SQL Benutzer eintragen. Muß die Rechte besitzen, Einräge in die Datenbank vornehmen zu dürfen
SQLUSER="vmail"

#Paßwort des SQL-Benutzers
SQLUSERPASSWD=""

#Datenbankname 
DB="vmail"


function createUser {
    USER=$1
    LTD=$2
    echo "Bitte das Passwort für den neuen Benutzer $USER angeben:"
	HASH=`doveadm pw -s $CRYPT`
	SQLINSERTUSER="INSERT into users (username, domain, password) values ('$USER', '$LTD', '$HASH');"
	echo "Die SQL Syntax lautet: "$SQLINSERTUSER
	echo "Schreibe Eintrag in Datenbank"
    mysql --user="$SQLUSER" --password="$SQLUSERPASSWD" --database="$DB"  --execute="$SQLINSERTUSER"

}

function createAlias {
    ALIAS=$1
	DESTINATION=$2
	SQLINSERTALIAS="INSERT into aliases (source, destination) values ('$ALIAS', '$DESTINATION');"
	echo "Die SQL Syntax lautet: "$SQLINSERTALIAS
	echo "Schreibe Eintrag in Datenbank"
    mysql --user="$SQLUSER" --password="$SQLUSERPASSWD" --database="$DB"  --execute="$SQLINSERTALIAS"
}

function createDomain {
    DOMAIN=$1
    SQLINSERTDOMAIN="insert into domains (domain) values ('$DOMAIN');"
	echo "Die SQL Syntax lautet: "$SQLINSERTDOMAIN
	echo "Schreibe Eintrag in Datenbank"
    mysql --user="$SQLUSER" --password="$SQLUSERPASSWD" --database="$DB"  --execute="$SQLINSERTDOMAIN"
}

echo "Anzahl: "$#

if [ $# -gt 0 ] ; then
	if [ "$1" == "createuser" ] ; then
         if [ $# -gt 2 ] ; then
            createUser $2 $3
        else
            echo "1 oder 2 Parameter (fehlen Name, Domain angeben)"
        fi
    elif [ "$1" == "createalias" ] ; then
        if [ $# -gt 2 ] ; then
            createAlias $2 $3
        else
            echo "1 oder 2 Parameter fehlen (Quelladresse, Zieladresse angeben)"
        fi
    elif [ "$1" == "createdomain" ] ; then
        if [ $# -gt 1 ] ; then
            createDomain $2
        else
            echo "1 Parameter fehlt (Domain angeben)"
        fi
    fi
else
	echo "Skript zum Anlegen von Benutzern, Aliases und Domains in einer MySQl Datenbank."
fi
