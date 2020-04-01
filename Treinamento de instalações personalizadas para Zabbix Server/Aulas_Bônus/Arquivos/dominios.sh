#!/bin/bash
############### REGRA DE DESCOBERTA LLD DOMINIO #############
case $1 in
     DISCOVERYDOMAIN)
     #VERIFICADOMINIO
     dominio=$(whois $2 | grep domain: | awk '{print $2}')
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
################ DESCOBERTA DE ITENS LLD #########################
 case $1 in
	 INFODOMAIN)
		 whois $2 | grep $3: | awk '{print $2,$3,$4,$5,$6}' | head -1
		 ;;
 esac
################ FIM DAS COLETAS DE ITENS ########################
#
################ DESCOBERTA DIAS DE EXPIRACAO DO DOMINIO EM LLD ##
 case $1 in
         INFODOMAINEXP)
                 data=$(whois $2 | grep "expires" | awk '{print $2}')
                 expira=$((`date -d "$data" '+%s'`))
                 hoje=$((`date '+%s'`))
                 lefts=$(($expira - $hoje))
                 leftd=$(($lefts/86400))
                 echo $leftd
                 ;;
 esac
################ FIM DAS COLETAS DE ITENS ########################


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

