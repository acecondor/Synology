#!/bin/bash
#
# versione 2020.07.22.003
#
##############################################################################
#
# allineamento certificato Synology > Synthing 

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