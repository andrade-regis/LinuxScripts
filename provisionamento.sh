#!/bin/bash

echo "Iniciando o script de provisionamento..."

for user in carlos maria joao debora sebastian; do
  if id "$user" &>/dev/null; then
    userdel -r "$user"
    echo "Usuário $user removido."
  fi
done

for group in GRP_ADM GRP_VEN GRP_SEC; do
  if getent group "$group" > /dev/null; then
    groupdel "$group"
    echo "Grupo $group removido."
  fi
done

rm -rf /public /adm /ven /sec
echo "Diretórios removidos."

groupadd GRP_ADM
groupadd GRP_VEN
groupadd GRP_SEC
echo "Grupos criados."

mkdir /public /adm /ven /sec
echo "Diretórios criados."

chown root:root /public /adm /ven /sec

chmod 777 /public
chmod 770 /adm
chmod 770 /ven
chmod 770 /sec

useradd carlos -m -s /bin/bash -G GRP_ADM
useradd maria -m -s /bin/bash -G GRP_ADM
useradd joao -m -s /bin/bash -G GRP_VEN
useradd debora -m -s /bin/bash -G GRP_VEN
useradd sebastian -m -s /bin/bash -G GRP_SEC

chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec

echo "Script finalizado com sucesso."
