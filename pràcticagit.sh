echo "Benvingut a la primera pràctica, tria una opció"
read resposta

while [[ $resposta != "q" ]]; do
    # 2n apartat: llistar tots els països
    if [[ $resposta == "lp" ]]; then
        cut -d',' -f7,8 cities.csv | sort | uniq
    fi

