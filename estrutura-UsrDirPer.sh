#!/usr/bin/env bash

DIRETORIOS=("/adm" "/ven" "/sec" "/publico")
GRUPOS=("GRP_ADM" "GRP_VEN" "GRP_SEC")
USRADM=("carlos" "maria" "joao")
USRVEN=("debora" "sebastiana" "roberto")
USRSEC=("josefina" "amanda" "rogerio")

echo "Gerenciando diretórios"
for ((i=0; i<${#DIRETORIOS[@]}; i++))
do
if [ "${DIRETORIOS[$i]}" != "/publico" ];
  then
    mkdir -m 770 "${DIRETORIOS[$i]}"
  else
    mkdir -m 777 "${DIRETORIOS[$i]}"
    chown root "${DIRETORIOS[@]}"
fi
done

echo "Gerenciando grupos"
for ((i=0; i<${#GRUPOS[@]}; i++))
do
if [ "${GRUPOS[$i]}" = "GRP_ADM" ];
  then
    groupadd "${GRUPOS[$i]}" && chown root:"${GRUPOS[0]}" "${DIRETORIOS[0]}"
 elif [ "${GRUPOS[$i]}" = "GRP_VEN" ];
  then
    groupadd "${GRUPOS[$i]}" && chown root:"${GRUPOS[1]}" "${DIRETORIOS[1]}"
 elif [ "${GRUPOS[$i]}" = "GRP_SEC" ];
  then
    groupadd "${GRUPOS[$i]}" && chown root:"${GRUPOS[2]}" "${DIRETORIOS[2]}"
fi
done

echo "Gerenciando usuarios do setor:"
echo ">> Administrativo"
for ((i=0; i<${#USRADM[@]}; i++))
do
    useradd "${USRADM[$i]}" -m -s /bin/bash -p "$(openssl passwd adm123)" -G "${GRUPOS[0]}"
done

echo ">> Vendas"
for ((i=0; i<${#USRVEN[@]}; i++))
do
    useradd "${USRVEN[$i]}" -m -s /bin/bash -p "$(openssl passwd ven456)" -G "${GRUPOS[1]}"
done

echo ">> Secretaria"
for ((i=0; i<${#USRSEC[@]}; i++))
do
    useradd "${USRSEC[$i]}" -m -s /bin/bash -p "$(openssl passwd sec789)" -G "${GRUPOS[2]}"
done

echo "Finalizado!"
