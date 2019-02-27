#!/bin/bash
#usage : ./essai.sh sample.csv SAMD11
variable=${1}
if [ -z "${variable}" ]
then 
	echo "TEXTTAB file not passed as parameter"
	exit 1
fi

variable=${2}
if [ -z "${variable}" ]
then 
	echo "TEXTTAB file not passed as parameter"
	exit 1
fi

#print which gene passed as 2nd parameter
echo "my imput regular expression: $2"

#print nammed of the analysed csv file as 1st parameter
nom_fichier=$(echo $1 | sed -re 's/(.*).csv/\1/')
echo "my analyzed file is: $nom_fichier.csv"


#transform , in tabulation
sed 's/,/\t/g' $1 > espace.csv

#remove " around strings
sed 's/"//g' espace.csv > guillemet.csv

#select headers
cat guillemet.csv | head -1 > headers.csv

#select lines which contained the regular expression
awk ''/$2/'' guillemet.csv > gene.csv

cat headers.csv gene.csv > results.csv
echo "number of lines in the imput csv file:"
wc -l results.csv
echo "number of lines in the output csv file comprising the regular expression:"
wc -l $1

mv results.csv $(echo results.csv | sed "s/\./".$nom_fichier.$2"\./")

rm espace.csv
rm guillemet.csv
rm headers.csv

