#createDovecotMySQLEntries
=========================

##Uebersicht
Dieses Shell Skript dienst zum Erstellen bon Benutzer-, alias- und Domain-Eintraegen in einer MyL-DB. Die Tabellen der DB muessen die Struktur der Beispiel-Tabellen aus den Dovecot Konfigurationsdateien haben, andernfalls ist eine Nutzung dieses Skript nicht moeglich.

Wird das Skript das erste Mal aufgerufen wird eine Konfigurationsdatei unter ~/.createDovecotMySQLEntries erzeugt. **Achtung**: In dieser Datei wird unter anderem das abgefragte Passwort gespeichert! Dies kann ein Sicherheitsrisiko darstellen.

Es findet keine Syntax-Ueberpruefung der Eingaben statt, d.h. wird bei zu uebergebenden Domain oder emailadressen syntaktisck unkorrekte Parameter uebergeben, so werden diese ungeprueft in der DB gespeichert. Ein Loeschen/Editieren der Datensaetze ist derzeit nicht moeglich.

##Installation
Zur Installation muss nur die Datei heruntergeladen werden, Ausfuehrrechte erhaltenund ausgefuehrt werden.

##Benutzung des Skripts

### Benutzer anlegen
Einen neuen Benutzer erstellt man durch folgenden Befehl:

     createuser neueEmailadresse Domain

neueEmailadresse ist die neue Emailadresse und gleichzeitig der Benutzer zur Authentifizierung. Domain ist die Domain, unter der der Benutzer erreichbar sein soll. Das Passwort fuer den neuen Benutzer wird danach abgefragt.

### Alias/Weiterleitung anlegen
Erstellt eine Email-Weiterleitung

     createalias Quelladresse Zieladresse

Dieser befehl leiteanschliessend alle e Mails der Quell- an die Zieladresse weiter

### Domain anlegen
Erstellt eine neue Domain

     createdomain domain

Eine Domain muss die Form 'test.de' haben.
