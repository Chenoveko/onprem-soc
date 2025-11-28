#!/bin/bash

counter=0

while IFS=" " read -r name lastname; do
    counter=$((counter+1))
    echo "$counter $name, $lastname"
    age=$(shuf -i 18-100 -n 1)

    mariadb -u root -p1234 people -e "insert into register values ($counter,'$name','$lastname',$age)"
    echo "$counter, $name, $lastname, $age was correctly imported"
done < people.txt