#!/bin/bash
#
# versione 2024.04.10.003
#
##############################################################################
#
# Use Synology default certificate for Syncthing web GUI
# Eseguire come root / Run as root
# Usare il parametro "force" per ignorare i controlli / Use parameters "force" to bypass check

# imposto percorso certificati / set certificates path 
cert_orig="/usr/syno/etc/certificate/system/default"
cert_dest="/volume1/@appdata/syncthing"
readonly cert_orig
readonly cert_dest

# verifico se certificati differenti / check if certificates is different
DIFF=$(diff $cert_orig/cert.pem $cert_dest/https-cert.pem)
echo "Diff: $DIFF"
if [ "$1" == "force" ]
then
  DIFF=="force"
  echo "Forzo procedura / Force procedure"
fi

if [ "$DIFF" != "" ]
then
  echo "Eseguo aggiornamento certificati / Run certificates update"
  
  # elimino vecchi salvataggi / delete old backups
  echo "Elimino vecchi salvataggi / Delete old backups"
  rm $cert_dest/https-cert.pem.bk
  rm $cert_dest/https-key.pem.bk

  # creo nuovo salvataggio / make new backups
  echo "Creo nuovo salvataggio / Make new backups"
  mv $cert_dest/https-cert.pem $cert_dest/https-cert.pem.bk
  mv $cert_dest/https-key.pem $cert_dest/https-key.pem.bk 

  # copio il corrente certificato predefinito / copy new DSM cert to Syncthing
  echo "Copio il corrente certificato predefinito / copy new DSM cert to Syncthing"
  cp $cert_orig/cert.pem $cert_dest/https-cert.pem
  cp $cert_orig/privkey.pem $cert_dest/https-key.pem
  
  # imposto le autorizzazioni / set permissions
  echo "Imposto autorizzazioni file / Set permissions"
  chown sc-syncthing:sc-syncthing $cert_dest/https-cert.pem
  chown sc-syncthing:sc-syncthing $cert_dest/https-key.pem
  chmod 640 $cert_dest/https-cert.pem
  chmod 600 $cert_dest/https-key.pem
  
  # riavvio servizio Syncthing / restart Syncthing service
  echo "Riavvio servizio Syncthing / Restart Syncthing service"
  systemctl restart pkgctl-syncthing
else 
  echo "Nulla da fare! / Nothing to do!"
fi
