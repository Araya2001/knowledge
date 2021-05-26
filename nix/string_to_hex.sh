#!/bin/bash

printf "Ingrese un string:\n$ "

read input

printf "\nString Ingresado:\n"
printf "$input"
printf "\n\nValor HEX:\n"
printf "$input" | od -A n -t x1