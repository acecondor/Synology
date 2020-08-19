Lo script permette di utilizzare il certificato predefinito di DSM per Syncthing
Testato con DSM 6.2.3

Schedulare lo script come root con il seguento comando "bash /volumeX/PercorsoScript/SyncthingCert.sh"; solo in caso di differnza tra certificato predefinito DSM e certificato Syncthing viene eseguita la copia e il riavvio.

Fonte idea: https://gist.github.com/pierdom/7ed7fdbb24cf839d19800137fc6784c5

############################
The script allows you to use the DSM default certificate for Syncthing
Tested with DSM 6.2.3

Schedule the script as root with the following command "bash /volumeX/ScriptPath/SyncthingCert.sh"; only if difference between the DSM default certificate and the Syncthing certificate the files is copied and restarted the service.

Use system certificates for Syncthing web GUI (SSL certificate setup) and automatic restart.
