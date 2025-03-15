# IaC - Infraestrutura com Código

## Objetivo

Este projeto tem como objetivo provisionar uma infraestrutura básica utilizando **Bash Scripts** para automatizar a criação e a configuração de diretórios e permissões de usuários e grupos no sistema. O foco é garantir que as permissões de acesso aos diretórios sejam controladas de acordo com o grupo de cada usuário.

## Requisitos

- O provisionamento e a configuração da infraestrutura devem ser feitos através de **Bash Scripts**.
- O **usuário root** será o dono de todos os diretórios criados.
- O diretório **/publico** será acessível por todos os usuários com permissão total.
- Cada grupo de usuários terá permissão total em seu respectivo diretório.
- **Usuários não pertencentes a um grupo não terão permissão** de leitura, escrita e execução nos diretórios dos outros grupos.

## Estrutura de Diretórios

O script criará os seguintes diretórios:

- `/publico`  
- `/adm`  
- `/ven`  
- `/sec`  

Esses diretórios representarão os recursos compartilhados e específicos para cada grupo de usuários.

## Grupos de Usuários

O projeto cria os seguintes grupos de usuários:

- `GRP_ADM` - Grupo de Administradores
- `GRP_VEN` - Grupo de Vendas
- `GRP_SEC` - Grupo de Segurança

## Usuários

Os seguintes usuários serão criados e atribuídos aos respectivos grupos:

- **GRP_ADM**:
  - `carlos`
  - `maria`
  - `joao`

- **GRP_VEN**:
  - `debora`
  - `sebastiana`
  - `roberto`

- **GRP_SEC**:
  - `josefina`
  - `amanda`
  - `rogerio`

## Permissões de Acesso

- **/publico**: Todos os usuários terão permissão total (leitura, escrita e execução) neste diretório.
- **/adm**: Somente os usuários do grupo `GRP_ADM` terão permissão total. Os outros grupos não terão acesso.
- **/ven**: Somente os usuários do grupo `GRP_VEN` terão permissão total. Os outros grupos não terão acesso.
- **/sec**: Somente os usuários do grupo `GRP_SEC` terão permissão total. Os outros grupos não terão acesso.

## Como Executar

1. **Clone o repositório** para o seu ambiente:

```bash
git clone https://github.com/thiago-dev-cyber/IaC.git
cd IaC
```

2. Dê permissão de execução ao script Bash:

```bash
chmod +x terra_form.sh
chmod +x limpeza.sh
```
3. Execute o script para criar os diretórios, grupos e usuários:

```bash
sudo ./terra_form.sh
```
3.1 Caso queira desfazer as alterações feitas pelo `terra_form.sh` rode o `limpeza.sh`:
```bash
sudo ./limpeza.sh
```
