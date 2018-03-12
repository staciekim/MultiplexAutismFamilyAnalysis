#!/bin/bash

#NOTES --------------
#Here we take two files, anno_af.csv which is a .csv generated from this SQL query:
# SELECT chr, pos, ref, alt, af
# FROM anno
# WHERE pos IN
# (SELECT pos
# FROM vars
# WHERE id = 'AU016203' OR id = 'AU2756305' OR id = 'AU081206' OR id='AU1065301' OR id='AU1348302' 
# OR id='AU1921302' OR id='AU3199301' OR id='AU019404' OR id='AU1025302'
# AND filter='PASS' AND length(ref) = 1 AND length(alt) = 1 AND ref !='.' AND alt !='.')
# ORDER BY pos


#And the file unaff_vars.csv generated from this SQL query:
# SELECT id, pos, chr, alt, gt
# FROM vars
# WHERE id = 'AU016203' OR id = 'AU2756305' OR id = 'AU081206' OR id='AU1065301' OR id='AU1348302' 
# OR id='AU1921302' OR id='AU3199301' OR id='AU019404' OR id='AU1025302'
# AND (filter='PASS' OR filter='VQSRTrancheSNP99.90to100.00') 
# AND ref !='.' 
# AND alt !='.'
# AND (gt='1/0' OR gt='0/1' OR gt='1/1')
#----------------------
# This script finds variants that are "overexpressed" in our n=9 group
# based on the population allele frequency. Because our n is small, we do look at observed/expected
# rather we look at observed - expected and then filter for (obs-exp) > X where x is variable
# a low x will give more variants, while a high x will filter more. This filtering can be done in the last
# awk command, or it can be done in the sql table uploaded into the ihart database (cs273a_unaffected_vars)
#----------------------

#CODE BELOW

# ./clean_file.sh anno_af.csv
# Above clean_file takes very long on 2 Gb file


# With n = 9, output expected # of seen (dipload) alleles, sort, save
# awk '{ print $1"_"$2"_"$4, $3, $5 * 18}' anno_af.csv | sort -k 1,1 > anno_af_sorted.txt

#Remove header line from anno_af_exp.txt
# gsed -i '1d' anno_af_exp.txt


# ./clean_file.sh unaff_vars_og.txt
# Above clean_file will take very long time on 17 Gb file


# Get rid of the individual ID, sort, count unique, save to file
# awk '{ if ($5 == "1/0" || $5 == "0/1") num=1; else num=2; for(i=0;i<num;i++) print $3"_"$2"_"$4}' unaff_vars_og.txt | sort -k 1,1 | uniq -ci  > unaff_vars_uniq.txt 



#JOIN unaff_vars and anno_af files ON position field
# join -1 2 -2 1 -o 1.2,2.2,1.1,2.3 unaff_vars_uniq.txt anno_af_sorted.txt > vars_of_int.txt

# Reformat for SQL upload
# awk '{ if (1 > 0) { split($1, a, "_"); print a[1], a[2], a[3], $2, $3, $4} }' vars_of_int.txt > sql_ready_vars.txt