#!/bin/bash
SCRIPTFILE=noip-ducv6.sh
DAMONFILE=noip-duc.service

if [ $(whoami) == root ]; then

	echo "Acesso root OK"
else    
	echo "Necessário Acesso root !"
	echo "eleve o terminal para root e execute novamente o script"
	exit 0
fi

echo "Informe o login no site NoIP: "
read loginnoip

echo "Informe a senha: "
read senhanoip

echo "Informe o registro a ser atualizado ex: myreg.ddns.net: "

read registro

echo "Informe a interface de rede para coletar o IP: Ex: eth0, enp1s0 "

read interface

sed -i "s/interface=.*/interface='$interface'/g" $SCRIPTFILE 
sed -i "s/user=.*/user='$loginnoip'/g" $SCRIPTFILE
sed -i "s/pass=.*/pass='$senhanoip'/g" $SCRIPTFILE
sed -i "s/hostname=.*/hostname='$registro'/g" $SCRIPTFILE

echo "Verificando asquivos necessários para prosseguir"

if test -f "$SCRIPTFILE"; then
	echo "$SCRIPTFILE OK."
fi
if test -f "$DAMONFILE"; then
	echo "$DAMONFILE OK."
fi

chmod +x $SCRIPTFILE
chmod +x $DAMONFILE
cp $SCRIPTFILE /usr/local/bin
cp $DAMONFILE /usr/lib/systemd/system
systemctl daemon-reload
systemctl enable noip-duc --now

echo "Instalação realizada"
#/usr/lib/systemd/system
