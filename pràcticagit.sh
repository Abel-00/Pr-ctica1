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
        cut -d',' -f4,5 sel.csv | uniq
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
     #9e apartat: extreure les poblacions de l'estat seleccionat
    if [[ $resposta == "ece" ]];then
        touch $codiestat.csv
        awk -F ',' -v codi="$codiestat" '$4 == codi {print $2,$11}' sel.csv >> $codiestat.csv
        cat $codiestat.csv
    fi
    #10e apartat: Obtenir les dades d'una ciutat de la wikidata
    if [[ $resposta == "gwd" ]];then
            echo Tria una ciutat:
            read ciutat
            wikidata=$(cut -d',' -f1,2 $codiestat.csv | grep -m 1 "$ciutat" | cut -d' ' -f2)
            if [[ $(grep "$ciutat" sel.csv) && $wikidata != "" ]]; then
                    touch $wikidata.json
                    wget "https://www.wikidata.org/wiki/Special:EntityData/$wikidata.json" -O "$wikidata.json"
                    cat "$wikidata.json"
           fi
    fi
    #11e apartat: Mostrar les estadístiques
    if [[ $resposta == "est" ]];then
        c1=0
        awk -F ',' '$9 > 0 {c1++} END {print "Nord",c1}' cities.csv
        c2=0
        awk -F ',' '$9 < 0 {c2++} END {print "Sud",c2}' cities.csv
        c3=0
        awk -F ',' '$10 > 0 {c3++} END {print "Est",c3}' cities.csv
        c4=0
        awk -F ',' '$10 < 0 {c4++} END {print "Oest",c4}' cities.csv
        c5=0
        awk -F ',' '$9 == 0 && $10 == 0 {c5++} END {print "No ubicació",c5}' cities.csv
        c6=0
        awk -F ',' '$11 == "" {c6++} END {print "No Wdld",c6}' cities.csv
    fi
    #if [[ $resposta != "est" && $resposta != "lp"  && $resposta != "ece" & $resposta != "gwd" && $resposta != "ecp" and $resposta !="lp" && $resposta != "sc" && $resposta != "se" && $resposta != "le" && $resposta != "lcp" ]];then
    
	    #echo "Opció desconeguda"
    #fi
    if [[ $resposta != "est" && $resposta != "lp" && $resposta != "ece" && $resposta != "gwd" && $resposta != "ecp" && $resposta != "sc" && $resposta != "se" && $resposta != "le" && $resposta != "lcp" ]]; then
    
	    echo "Opció desconeguda"
    fi

    echo "Tria una opció"
    read resposta
done


if [[ $resposta == "q" ]]; then
        echo Sortint ....
        exit
fi

