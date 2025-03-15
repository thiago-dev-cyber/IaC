#!/bin/bash

# Definindo variáveis de cor
RESET="\033[0m"       # Resetar a cor
VERMELHO="\033[31m"   # Vermelho
VERDE="\033[32m"      # Verde
AMARELO="\033[33m"    # Amarelo
AZUL="\033[34m"       # Azul
MAGENTA="\033[35m"    # Magenta
CIANO="\033[36m"      # Ciano
BRANCO="\033[37m"     # Branco

# Verifica se houve falha na execucao do ultimo comando.
verifica_erro() {
    if [ $? -ne 0 ];then
        echo -e $1
        exit 1
    fi
}

# Funcao responsavel por criar os usuarios.
cria_usuario() {
    usuario=$1
    echo -e "$AMARELO[*] Criando o usuario $CIANO$usuario$RESET"
    useradd $usuario -m -s /bin/bash -p $(openssl passwd -6 123456)
    chage -d 0 $usuario
    verifica_erro "$VERMELHO[!] Não foi possivel criar o usuario $CIANO$usuario$RESET"
}

# Garantindo a execucao como root.
if [ $EUID -ne 0 ];then
    echo -e "$VERMELHO[!] Necessario a execução como Super Usuario (Root)!$RESET"
    exit
fi


# ================= Criacao dos diretorios ==================
# /publico /adm /ven /sec

echo -e "$AMARELHO[*] Criando os diretorios 'publico, adm, ven e sec'...$RESET"
mkdir /publico /ven /sec /adm 2>/dev/null
verifica_erro "$VERMELHO[!] Não foi possivel criar os diretorios.$RESET"

echo -e "$VERDE[+] Diretorios criados com sucesso!$RESET"
# ============================================================

# ================= Criação dos usuarios =====================

usuarios=("carlos" "maria" "joao" "debora" "sebastiana" "roberto" "josefina" "amanda" "rogerio")

for usuario in "${usuarios[@]}";do
    cria_usuario $usuario
done
echo -e "$VERDE[+] Usuarios criados com sucesso!$RESET"
# ============================================================


# ================ Criacao dos grupos ========================
grupos=("GRP_ADM" "GRP_VEN" "GRP_SEC")

echo -e "$AMARELO[*] Criando os grupos$RESET"
for grupo in "${grupos[@]}";do
    groupadd $grupo
    verifica_erro "$VERMELHO[!] Não foi possivel criar o grupo$RESET $CIANO$grupo$RESET"
done
echo -e "$VERDE[+] Grupos criados com sucesso!$RESET"
# =============================================================

# ===== Adicionando os usuarios aos seus respectivos grupos. ====
usermod -aG GRP_ADM carlos
usermod -aG GRP_ADM maria
usermod -aG GRP_ADM joao

usermod -aG GRP_VEN debora
usermod -aG GRP_VEN sebastiana
usermod -aG GRP_VEN roberto

usermod -aG GRP_SEC josefina
usermod -aG GRP_SEC amanda
usermod -aG GRP_SEC rogerio

# Definindo as permissoes de acesso.
chmod 777 /publico
chmod 770 /adm
chmod 770 /sec
chmod 770 /ven

# Alterando o dono eo grupo dos diretorios.
chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec
