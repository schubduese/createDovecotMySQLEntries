#createDovecotMySQLEntries
=========================

##Uebersicht
Dieses Shell Skript dienst zum Erstellen bon Benutzer-, alias- und Domain-Eintraegen in einer MyL-DB. Die Tabellen der DB muessen die Struktur der Beispiel-Tabellen aus den Dovecot Konfigurationsdateien haben, andernfalls ist eine Nutzung dieses Skript nicht moeglich.

Wird das Skript das erste M aufgerufen wird eine Konfigurationsdatei unter ~/.createDovecotMySQLEntries erzeugt. *Achtung*: In dieser Datei wird unter anderem das abgefragte Passwort gespeichert! Dies kann ein Sicherheitsrisiko darstellen.

##Benutzung des Skripts

### Benutzer anlegen
     createuser

### Alias anlegen
     createalias

### Domain anlegen
     createdomain
