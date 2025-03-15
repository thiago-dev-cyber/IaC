#!/bin/bash

set -e # garante que o script nao termina em caso de falhas

# A paga as pastas criadas pelo script terra_form
rm -rf /publico /adm /sec /ven

# Remove os usuarios adicionados pelo script terra_form
usuarios=("carlos" "maria" "joao" "debora" "sebastiana" "roberto" "josefina" "amanda" "rogerio")
for user in "${usuarios[@]}";do
   userdel -f -r $user || true
done

# Remove os grupos criados pelo script terra_form
grupos=("GRP_ADM" "GRP_VEN" "GRP_SEC")

for grupo in "${grupos[@]}";do
    groupdel $grupo

done
