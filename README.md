# MultiplexAutismFamilyAnalysis

To strip a variant file, run:

python variant_stripper.py and modify the variant file
you want to strip from. 

coomands_Athena_data - sql commands to get the filtered data from Athena

data - folder with files directly downloaded from Athena

./clean_file.sh - converts the .csv file downloaded from athena into tab limited file, without the double quotes. run as: $ ./clean_file.sh <filename>

unaffected_family.txt - list of unaffected males that have family with at least 1 affected male too.

affected_family.txt - list of affected males that have family with at least 1 unaffected male too.

unaffected_males_affected_families.csv - list of unaffected males with at least 1 parent affected.

affected_males_affected_families.csv - list of affected males with at least 1 parent affected.
