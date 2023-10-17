echo "Benvingut a la primera pràctica, tria una opció"
read resposta

while [[ $resposta != "q" ]]; do
    # 2n apartat: llistar tots els països
    if [[ $resposta == "lp" ]]; then
        cut -d',' -f7,8 cities.csv | sort | uniq
    fi
 # 3r apartat: seleccionar un país
    if [[ $resposta == "sc" ]]; then
        echo "Nom del país:"
        read nompais

        if [[ $nompais == "" ]]; then
            codipais=$codipais
        else
            if [[ $(cut -d',' -f8 cities.csv | grep "$nompais") = "" ]]; then
                codipais="XX"
                echo $codipais
            else
                codipais=$(cut -d',' -f7,8 cities.csv | grep -m 1 "$nompais" | cut -d',' -f1)
                awk -F ',' -v codi="$codipais" '$7 == codi {OFS=","; print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11}' cities.csv > sel.csv
            fi
        fi
    fi
 # 4rt apartat: seleccionar un estat
    if [[ $resposta == "se" ]]; then
        echo "Nom estat:"
        read nomestat
        if [[ $nomestat == "" ]]; then
            codiestat=$codiestat
        else
                if [[ $(cut -d',' -f5 sel.csv | grep "$nomestat") = "" ]];then
                        codiestat="XX"
                        echo $codiestat
                else
                        codiestat=$(cut -d',' -f4,5 sel.csv | grep -m 1 "$nomestat" | cut -d',' -f1)
                fi
       fi
    fi
     #5e apartat: llistar els estats del país seleccionat
    if [[ $resposta == "le" ]];then
        cut -d',' -f4,5 sel.csv
    fi
    #6e apartat : llistar les poblacions del país seleccionat
    if [[ $resposta == "lcp" ]];then
        cut -d',' -f2,11 sel.csv
    fi
    #7e apartat: extreure les poblacions del pais seleccionat
    if [[ $resposta == "ecp" ]];then
        touch $codipais.csv
        cut -d',' -f2,11 sel.csv > $codipais.csv
        cat $codipais.csv
    fi
    #8e apartat: llistar les poblacions de l'estat seleccionat
    if [[ $resposta == "lce" ]];then
        awk -F ',' -v codi="$codiestat" '$4 == codi {print $2,$11}' sel.csv
    fi
