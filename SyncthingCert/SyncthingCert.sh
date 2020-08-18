#!/bin/bash
#
# versione 2020.08.18.001
#
##############################################################################
#
# allineamento certificato Synology > Synthing 

# verifico se certificati origine sono cambiati nelle ultime 24 ore
# diffday = differenza in giorni da verificare
# cnt = numero fine cambiati nell'intervallo di data

diff=1
cnt=$(find /usr/syno/etc/certificate/system/default -mtime -$diff -ls | wc -l  2>&1)

# differenza in minuti (alternativa)
# cnt=$(find /usr/syno/etc/certificate/system/default -mmin -$diff -ls | wc -l  2>&1)

# imposto percorso certificati Syncthing
cert_orig="/usr/syno/etc/certificate/system/default"
cert_dest="/volume1/@appstore/syncthing/var"
readonly cert_orig
readonly cert_dest

# elimino vecchi salvataggi
rm $cert_dest/https-cert.pem.bk
rm $cert_dest/https-key.pem.bk

# creo nuovo salvataggio
mv $cert_dest/https-cert.pem $cert_dest/https-cert.pem.bk
mv $cert_dest/https-key.pem $cert_dest/https-key.pem.bk

# copio il corrente certificato predefinito
cp $cert_orig/cert.pem $cert_dest/https-cert.pem
cp $cert_orig/privkey.pem $cert_dest/https-key.pem

# imposto le autorizzazioni
chown sc-syncthing:syncthing $cert_dest/https-cert.pem
chown sc-syncthing:syncthing $cert_dest/https-key.pem
chmod 640 $cert_dest/https-cert.pem
chmod 600 $cert_dest/https-key.pem

# riavvia Syncthing solo se i file sono cambiati
if [ cnt > 0 ]
then
  echo "Riavvia servizio... "$cnt
  # inserire riavvio servizio, in costruzione
else 
  echo "Nulla da fare"
fi
