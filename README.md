#createDovecotMySQLEntries
=========================

##Uebersicht
Dieses Shell Skript dient zum Erstellen von Benutzer-, alias- und Domain-Eintraegen in einer MySQL-DB. Die Tabellen der DB müssen die Struktur der Beispiel-Tabellen aus den Dovecot Konfigurationsdateien haben, andernfalls ist eine Nutzung dieses Skript nicht möglich.

Wird das Skript das erste Mal aufgerufen wird eine Konfigurationsdatei unter ~/.createDovecotMySQLEntries erzeugt. **Achtung**: In dieser Datei wird unter anderem das abgefragte Passwort gespeichert! Dies kann ein Sicherheitsrisiko darstellen.

Es findet keine Syntax-Überprüfung der Eingaben statt: Übergebende Parameter werden ungeprüft in die DB übernommen, d.h. Domain oder Emailadressen werden nicht syntaktisch überprüft und direkt in der DB gespeichert. Ein Löschen/Editieren der Datensätze ist derzeit nicht moeglich und muß über direkt über die DB erfolgen.

##Installation
Zur Installation muss nur die Datei heruntergeladen werden und mit den nötigen Ausführrechten ausgestattet werden (chmox +x createDovecotMySQLEntries.sh).

##Benutzung des Skripts

Befehle jeweils in dem Verzeichnis, in dem das Skript liegt, eingeben.

### Benutzer anlegen
Einen neuen Benutzer erstellt man durch folgenden Befehl:

     ./createDovecotMySQLEntries.sh createuser neueEmailadresse Domain

neueEmailadresse ist die neue Emailadresse und gleichzeitig der Benutzer zur Authentifizierung. Domain ist die Domain, unter der der Benutzer erreichbar sein soll. Das Passwort für den neuen Benutzer wird danach abgefragt.

### Alias/Weiterleitung anlegen
Erstellt eine Email-Weiterleitung

     createalias Quelladresse Zieladresse

Dieser Befehl leitet anschließend alle e-Mails der Quell- an die Zieladresse weiter.

### Domain anlegen
Erstellt eine neue Domain

     createdomain domain

Eine Domain muss die Form 'test.de' haben.
