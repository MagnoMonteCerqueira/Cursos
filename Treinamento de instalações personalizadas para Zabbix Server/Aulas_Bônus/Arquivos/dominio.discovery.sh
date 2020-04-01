#!/bin/bash
########################################################################
# Script: dominio.discovery.sh                                         #
# Author: Magno Monte Cerqueira                                        #
# Contact: Email: magno.cerqueira@2mti.com.br                          #
# Date: 2020-03-20                                                     #
#                                                                      #
# Treinamento de instalações personalizadas para Zabbix Server         #
#                                                                      #
# Description: Monitoramento do certificado digital zabbix server      #
#                                                                      #
#  2mti soluções e serviços                                            # 
#  https://www.2mti.com.br/treinamentos/                               #
########################################################################
#
# Versao 0.1
#
# NOME
#   dominio.discovery.sh
#
# DESCRICAO
#   Efetua a coleta de dados referente as informações de expiração do certificado digital do dominio.
#
#
#
# REQUISITOS
#    Validado para o Treinamento de instalações personalizadas para Zabbix Server.
#
#
# Controle de Versão
#  
#  Magno Monte Cerqueira - autor do Treinamento de instalações personalizadas para Zabbix Server.
#  
# NOTA
# Formas de execução do script 
#
# dominio.discovery.sh
#
#  
# 1 - Faça o donwload do script na pasta temporaria do zabbix server( cd /tmp );
# 2 - Torne o script executavel ( chmod +x dominio.discovery.sh ); 
# 3 - Inserir o arquivo dominio.discovery.sh no diretorio de sua escolha ( configurado no zabbix agent);
# 4 - Navegue até o diretorio do script; 
#
# TESTES
#
# Parâmetro DISCOVERYDOMAIN + Dominio - Posta o dominio configurado como host no formato json.
#
# EX:    ./dominio.discovery.sh DISCOVERYDOMAIN 2mti.com.br
#
#
# Parâmetro INFODOMAINCERT + Dominio - coleta a data de expiração do dominio e calcula com a data do zabbix server.
#
#
# EX:    ./dominio.discovery.sh INFODOMAINCERT 2mti.com.br
#
# ARQUIVOS QUE COMPÕE ESSE PROJETO
#
#
#  1- dominio.discovery.sh
#  2- Template_Monitoramento_Dominio_Treinamento_2MTI_VERSAO-0.1.xml
#  3- Dashboard dominios.json para Grafana.
#  4- dominio.discovery.conf
#
#
################################################## INICIO DO SCRIPT #############################################
################################################## VAREAVEIS DE AMBIENTE ########################################
#
############### REGRA DE DESCOBERTA LLD DOMINIO ################
#
#VERIFICA O NOME DO DOMINIO E POSTA O RESULTADO NO FORMATO JSON
case $1 in
     DISCOVERYDOMAIN)
     dominio=$( echo $2 | awk '{print $1}')
     echo -e "{
     \"data\":[
     "
     virgula=false
     for i in $dominio
     do
     if [ $virgula == true ]
     then 
          echo -e ","
     fi
     echo -e "
     {
                  \"{#DOMINIO}\":\"$i\"
     }
     "
     virgula=true
     done
     echo -e "  ]
}
"
;;
esac
################ FIM DA REGRA DE DISCOVERY #######################
#
################ DESCOBERTA DIAS DE EXPIRACAO DO DOMINIO EM LLD ##
 case $1 in
         INFODOMAINCERT)
                 data=$(openssl s_client -servername $2 -connect $2:443 2>&- | openssl x509 -enddate -noout | sed 's/^notAfter=//g')
                 expira=$((`date -d "$data" '+%s'`))
                 hoje=$((`date '+%s'`))
                 lefts=$(($expira - $hoje))
                 leftd=$(($lefts/86400))
                 echo $leftd
                 ;;
 esac
################ FIM DAS COLETAS DE ITENS ########################
#
########################################################################
# Script: dominio.discovery.sh                                         #
# Author: Magno Monte Cerqueira                                        #
# Contact: Email: magno.cerqueira@2mti.com.br                          #
# Date: 2020-03-20                                                     #
#                                                                      #
# Treinamento de instalações personalizadas para Zabbix Server         #
#                                                                      #
# Description: Monitoramento do certificado digital zabbix server      #
#                                                                      #
#  2mti soluções e serviços                                            # 
#  https://www.2mti.com.br/treinamentos/                               #
########################################################################

