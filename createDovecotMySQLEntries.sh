#!/bin/bash
# einen neuen eMailBenutzer anlegen, aliases anlegen 
# Version 0.1: 11.4.2014
#
#
#
CONFIGFILE="/home/joerg/.createDovecotmySQLEntries"
CRYPT="SHA512-CRYPT"

SQLUSER=""
SQLUSERPASSWD=""
DB=""


function createUser {
    USER=$1
    LTD=$2
    CRYPT="SHA512-CRYPT"
    echo "Bitte das Passwort für den neuen Benutzer $USER angeben:"
	HASH=`doveadm pw -s $CRYPT`
	SQLINSERTUSER="INSERT into users (username, domain, password) values ('$USER', '$LTD', '$HASH');"
	echo "Schreibe folgenden Eintrag in Datenbank: "$SQLINSERTUSER
    mysql --user="$SQLUSER" --password="$SQLUSERPASSWD" --database="$DB"  --execute="$SQLINSERTUSER"

}

function createAlias {
    ALIAS=$1
	DESTINATION=$2
	SQLINSERTALIAS="INSERT into aliases (source, destination) values ('$ALIAS', '$DESTINATION');"
	echo "Schreibe folgenden Eintrag in Datenbank: "$SQLINSERTALIAS
    mysql --user="$SQLUSER" --password="$SQLUSERPASSWD" --database="$DB"  --execute="$SQLINSERTALIAS"
}

function createDomain {
    DOMAIN=$1
    SQLINSERTDOMAIN="insert into domains (domain) values ('$DOMAIN');"
	echo "Schreibe folgenden Eintrag in DB: "$SQLINSERTDOMAIN
    mysql --user="$SQLUSER" --password="$SQLUSERPASSWD" --database="$DB"  --execute="$SQLINSERTDOMAIN"
}

function showHelp {
	echo  -e "Das Skript schreibt in eine MySQL-DB, welche von Dovecot benutzt wird, Eintrae fuer folgende Arten: Benutzer, aliases und Domains. Die Syntax lautet:\n createDovecotMySQLEntries createuser eMailAdresse Passwort - Erstellt neuen Benutzer. Das Passwort muss der Benutzer eingeben \n - createDovecotEntries createalias QuelleMailadresse ZieleMailadresse - Erzeugt einen eMail-Alias (weiterleitung) vond er Quell- auf die Zieladresse\n - createdomain domain Erzeugt einen neuen Domain-Eintrag (z.B. test-de)"
}

function createConfigfile {
	echo "Es wird eine neue Konfigurationsdatei erstellt (unter "$CONFIGFILE".)"
	read -p "Name des DB-Benutzers:" SQLUSER
	read -p "Passwort des DB-Benutzers:" SQLUSERPASSWD
	read -p "Name der Datenbank:" DB
	read -p "Versluesselungsart (Leer lassen fuer Standard: SHA-512)" CRYPT
	if [ -z "$CRYPT" ] ; then
		CRYPT="SHA512-Crypt"
	fi
	touch $CONFIGFILE
	echo -e "CRYPT="$CYRPT"\nSQLUSER="$SQLUSER"\nSQLUSERPASSWD="$SQLUSERPASSWD"\nDB="$DB > $CONFIGFILE
}

if [ $# -gt 0 ] ; then
    if [ ! -f "$CONFIGFILE" ] ; then
	createConfigfile
    fi
    source $CONFIGFILE
    if [ "$1" == "createuser" ] ; then
         if [ $# -gt 2 ] ; then
            createUser $2 $3
        else
            echo "1 oder 2 Parameter fehlen (Name(ohne@domain), Domain angeben, Passwort wird anschliessend abgefragt)"
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
    else
        showHelp
    fi
else
	showHelp
fi
