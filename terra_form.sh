#!/bin/bash

# Verifica se houve falha na execucao do ultimo comando.
verifica_erro() {
    if [ $? -ne 0 ];then
        echo $1
        exit 1
    fi
}

# Funcao responsavel por criar os usuarios.
cria_usuario() {
    usuario=$1
    echo "[*] Criando o usuario $usuario"
    useradd $usuario -m -s /bin/bash -p $(openssl passwd -6 123456)
    chage -d 0 $usuario
    verifica_erro "[!] Não foi possivel criar o usuario $usuario"
}

# Garantindo a execucao como root.
if [ $EUID -ne 0 ];then
    echo "Necessario a execução como Super Usuario (Root)!"
    exit
fi


# ------------ Criacao dos diretorios ----------------
# /publico /adm /ven /sec

echo "[*] Criando o diretorio '/publico'..."
mkdir /publico 2>/dev/null
verifica_erro "[!] Não foi possivel criar o diretorio /publico."

echo "[*] Criando o diretorio '/adm'..."
mkdir /adm 2>/dev/null
verifica_erro "[!] Não foi possivel criar o diretorio /publico."

echo "[*] Criando o diretorio '/ven'..."
mkdir /ven 2>/dev/null
verifica_erro "[!] Não foi possivel criar o diretorio /ven."

echo "[*] Criando o diretorio '/sec'..."
mkdir /sec 2>/dev/null
verifica_erro "[!] Não foi possivel criar o diretorio /sec."

echo "[+] Diretorios criados com sucesso!"
# ---------------------------------------

# ----- Criação dos usuarios ------

usuarios=("carlos" "maria" "joao" "debora" "sebastiana" "roberto" "josefina" "amanda" "rogerio")

for usuario in "${usuarios[@]}";do
    cria_usuario $usuario
done
echo "[+] Usuarios criados com sucesso!"
# ----------------------------------


# ----- Criacao dos grupos ---------
grupos=("GRP_ADM" "GRP_VEN" "GRP_SEC")

for grupo in "${grupos[@]}";do
    groupadd $grupo
    verifica_erro "[!] Não foi possivel criar o grupo $grupo"
done


# Difindo as permissoes de acesso.
# Colocar uma corzinha :V