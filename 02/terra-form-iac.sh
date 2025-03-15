#!/bin/bash

# Definindo variáveis de cor
RESET="\033[0m"       # Resetar a cor
VERMELHO="\033[31m"   # Vermelho
VERDE="\033[32m"      # Verde
AMARELO="\033[33m"    # Amarelo
AZUL="\033[34m"       # Azul
MAGENTA="\033[35m"    # Magenta
CIANO="\033[36m"      # Ciano

# Verifica se a houve algum problema na execução do ultimo comando.
verifica_erro() {
    menssagem=$1
    if [ $? -ne 0 ];then
        echo -e $menssagem
        exit 1
    fi
}

# Garantindo a execução como root
if [ $EUID -ne 0 ];then
    echo -e "$VERMELHO[!] Necessario a execução como Super Usuario (root).$RESET"
    exit 1
fi

# Verificando se existe uma nova versão dos pacotes.
echo -e "$AMARELO[*] Iniciando a atualização da lista de pacotes.$RESET"

apt-get update -y
verifica_erro "$VERMELHO[!] Não foi possivel atualizar a lista de repositorios.$RESET"
echo -e "$VERDE[+] Verificação concluida.$RESET"

# Atualizando os pacotes
echo -e "$AMARELO[*] Iniciando a atualização do sistema.$RESET"
apt-get upgrade -y
verifica_erro "$VERMELHO[!] Não foi possivel atualizar os pacotes do sistema.$RESET"
echo -e "$VERDE[+] Atualização concluida.$RESET"

# Instalar os softwares necessarios.
echo -e "$AMARELO[*] Iniciando a instalação dos pacotes necessarios...$RESET"
apt-get install apache2 unzip -y
verifica_erro "$VERMELHO[!] Não foi possivel instalar os pacotes necessarios.$RESET"
echo -e "$VERDE[+] Instalação concluida.$RESET"

# Baixar o conteudo do site do repositorio github
echo -e "$AMARELO[*] Baixando os arquivos do repositorio.$RESET"
wget -O /tmp/main.zip https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip
verifica_erro "$VERMELHO[!] Não foi possivel baixar os arquivos do repositorio.$RESET"
echo -e "$VERDE[+] Download Concluido.$RESET"

# Descompactar
echo -e "$AMARELO[*] Descompactando os arquivos.$RESET"
unzip /tmp/main.zip -d /tmp
verifica_erro "$VERMELHO[!] Não foi possivel descompactar os arquivos$RESET"
echo -e "$VERDE[+] Descompactação Concluida!"

# Mover o conteudo para a /var/www/html
echo -e "$AMARELO[*] Copiando os arquivos para /var/www/html ...$RESET"
cp -R /tmp/linux-site-dio-main/* /var/www/html
verifica_erro "$VERMELHO[!] Não foi possivel copiar os arquivos.$RESET"
echo -e "$VERDE[+] Copia dos arquivos concluida!"
echo -e "$VERDE O Servidor esta online!$RESET"



