set jour=%date:~0,2%
set mois=%date:~3,2%
set annee=%date:~6,4%
set heure=%time:~0,2%
set minute=%time:~3,2%
set seconde=%time:~6,2%
set fichier=sauvegarde_poei2018-%jour%-%mois%-%annee%_%heure%h-%minute%mn-%seconde%s.sql
mysqldump -u root poei2018 > "c:\test\poei2018\%fichier%"