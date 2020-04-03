#!/bin/bash

########################################################################
# Script: backup-banco-zabbix.sh                                       #
# Author: Magno Monte Cerqueira                                        #
# Contact: Email: magnopeem@gmail.com                                  #
# Date: 2020-03-16                                                     #
#                                                                      #
# Treinamento de instalações personalizadas para zabbix server         #
#                                                                      #
# Description: Script de backup do banco de dados                      #
#                                                                      #
#  2mti soluções e serviços                                            # 
#  http://treinamentos.2mti.com.br                                     #
########################################################################
#
# Versao 0.1
#
# NOME
#   backup-banco-zabbix.sh
#
# DESCRICAO
#   Efetua o backup dos dados referente as informações do servidor zabbix.
#
# REQUISITOS
#    Validado para o Treinamento de instalações personalizadas para zabbix server.
#
# Controle de Versão
#  
#  Magno Monte Cerqueira - autor do Treinamento de instalações personalizadas para zabbix server
#  
# NOTA
# Formas de execução do script 
#
# backup-banco-zabbix.sh
#
#
# 1 - Coloque o script no diretorio de sua preferencia;
# 2 - Edite as informações de nome do banco de dados(DB_NOME), usuario(DB_USUARIO), senha(DB_PASS),Diretorio do backup (BACKUP_DIRETORIO);  
# 3 - Deixe o script executavel com o comando (chmod +x backup-banco-zabbix.sh); 
# 4 - Agende uma tarefa no crontab para executar o horario que desejar;
#
# TESTES
#
# Parâmetro - Realiza o backup manualmente.
#
# EX:    ./backup-banco-zabbix.sh
#
#
############################################################################################
echo " ** ANALIZANDO OS PARAMETROS MYSQL ** "
DB_NOME='mysql'
DB_USUARIO='root'
DB_PASS=''
DB_PARAMETRO='--add-drop-table --add-locks --extended-insert --single-transaction -quick'
#
echo " ** ANALIZANDO OS PARAMETROS DO SISTEMA  ** "
DATE=`date +%Y-%m-%d`
MYSQLDUMP=/usr/bin/mysqldump
BACKUP_DIRETORIO=/tmp/mysql
BACKUP_NOME=zabbix-$DATE.sql
BACKUP_TAR=zabbix-$DATE.tar
#
echo " ** CRIANDO O BACKUP DA BASE DE DADOS $DB_NOME NO LOCAL $BACKUP_DIRETORIO COM NOME $BACKUP_NOME ** "
$MYSQLDUMP $DB_NOME $DB_PARAMETRO -u $DB_USUARIO -p$DB_PASS > $BACKUP_DIRETORIO/$BACKUP_NOME
#
echo " ** COMPACTANDO O BACKUP DA BASE DE DADOS $DB_NOME NO DIRETORIO $BACKUP_DIRETORIO COM NOME $BACKUP_NOME ** "
tar tar -cjf $BACKUP_DIRETORIO/$BACKUP_TAR -C $BACKUP_DIRETORIO $BACKUP_NOME --remove-files
#
echo " ** EXCLUINDO OS BACKUPS ANTIGOS COM MAIS DE 30 DIAS ** "
find $BACKUP_DIRETORIO/* -mtime +30 -delete
#
#
########################################################################
# Script: backup-banco-zabbix.sh                                       #
# Author: Magno Monte Cerqueira                                        #
# Contact: Email: magnopeem@gmail.com                                  #
# Date: 2020-03-16                                                     #
#                                                                      #
# Treinamento de instalações personalizadas para zabbix server         #
#                                                                      #
# Description: Script de backup do banco de dados                      #
#                                                                      #
#  2mti soluções e serviços                                            # 
#  http://treinamentos.2mti.com.br                                     #
########################################################################