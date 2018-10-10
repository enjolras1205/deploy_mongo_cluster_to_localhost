#!/usr/bin/env bash

sed_and_cmp() {
    vars=$1
    echo "vars ${vars[*]} template_file "$2" generate_file "$3
    pattern=$(gen_sed_pattern $1)
    sed $pattern $2 > tmp_file
    # diff tmp_file $3 || true
    mv tmp_file $3
}

gen_sed_pattern() {
    vars=$1
    sed_pattern=""
    for i in "${vars[@]}"; do 
        IFS='=' read key val <<< "${i}"
        val=$(echo $val | sed 's_/_\\/_g')
        sed_pattern=$sed_pattern"s/{"$key"}/"$val"/g;"
    done
    echo $sed_pattern
}