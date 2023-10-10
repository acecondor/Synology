Problema di volume1 pieno su Synology (hardware non Synology) con l'uso di SurveillanceStation

-Tramite Application Center di SurveillanceStation interrompere Local Display
-Lanciare il comando sudo -i e confermare con la password admin
-Lanciare il comando sudo rm /volume1/\@appstore/SurveillanceStation/local_display/.config/chromium-local-display/BrowserMetrics/*.pma
