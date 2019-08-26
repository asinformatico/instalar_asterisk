#!/bin/bash

# =================================================
#          script instalar_asterisk.sh
#      Fecha última modificación: 20/08/2019 
#       Instalación automatizada de Asterisk
#        por @as_informatico para BitUp2019
# =================================================

DOWNLOAD_DIR1=http://downloads.asterisk.org/pub/telephony/asterisk/old-releases
DOWNLOAD_FILE1=asterisk-11.25.3.tar.gz
INSTALL_DIR1=asterisk-11.25.3

cd /usr/src
apt-get update
apt-get upgrade

# Download Asterisk
echo "Asterisk iniciando descarga"
WGET_OUTPUT=$(2>&1 wget --progress=dot:mega \
              "$DOWNLOAD_DIR1/$DOWNLOAD_FILE1")

if [ $? -ne 0 ]
then
	# wget ha tenido un problema.
	echo 1>&2 $0: "$WGET_OUTPUT"  Exiting.
	exit 1
else
	echo "Asterisk ha sido descargado"
fi

echo "Descomprimiendo archivo descargado..."
tar -xzvf $DOWNLOAD_FILE1 

cd $INSTALL_DIR1
cd contrib/scripts
echo "Comprobando requisitos para la instalación..."
./install_prereq install
cd /
cd /usr/src
cd $INSTALL_DIR1
echo "Configurando archivos antes de la compilación..."
ASTERISK_CONFIGURE=$(2>&1 ./configure)

if [ $? -ne 0 ]
then
	# ./configure ha tenido un problema.
	echo 1>&2 $0: "$ASTERISK_CONFIGURE"  Exiting.
	exit 1
else
	echo "La configuracion de compilacion Asterisk ha sido realizada con exito"
fi

echo "Compilando e instalando Asterisk..."
Asterisk_MAKE=$(2>&1 make && make install)

if [ $? -ne 0 ]
then
	# ./make y make install han tenido un problema.
	echo 1>&2 $0: "$Asterisk_MAKE"  Exiting.
	exit 1
else
	echo "Asterisk ha sido instalado."
fi

echo "Instalando ficheros de ejemplo Asterisk..."

Asterisk_Samples=$(2>&1 make samples)

if [ $? -ne 0 ]
then
	# ./make y make install han tenido un problema.
	echo 1>&2 $0: "$Asterisk_Samples"  Exiting.
	exit 1
else
	echo "ficheros de ejemplo instalados correctamente"
fi

echo "Inciando el servicio Asterisk..."
/etc/init.d/asterisk start
/etc/init.d/asterisk status
echo "============================================================================================"
echo "Asterisk ya está instalado, recuerde editar sus ficheros de configuración en /etc/asterisk/ "
echo "                                                                                            "
echo "Puede iniciar la consola de Asterisk ejecutando el siguiente comando: asterisk -rvvv        "
echo "============================================================================================"

