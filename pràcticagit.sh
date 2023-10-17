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
