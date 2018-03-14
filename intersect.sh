for i in AU019404_AU019405 AU019404_AU019406 AU081206_AU081205 AU1025302_AU1025301 AU1065301_AU1065302 AU1065301_AU1065303 AU1065301_AU1065304 AU1348302_AU1348303 AU2756305_AU2756306 AU3199301_AU3199303; 
do
    ./clean_file.sh $i"_nc".csv
#    awk 'BEGIN {OFS="\t"} {print $1"_"$2"_"$3,$4,$5,$6}' $i.csv | sort -k1,1 > $i"_jf".csv
    cut -f 3 $i"_nc".csv | sort -u > $i"_jf".csv
done
join -1 1 -2 1 AU019404_AU019405_jf.csv AU019404_AU019406_jf.csv | sort -k1,1 > temp1
join -1 1 -2 1 temp1 AU081206_AU081205_jf.csv | sort -k1,1 > temp2
join -1 1 -2 1 temp2 AU1025302_AU1025301_jf.csv | sort -k1,1 > temp3
join -1 1 -2 1 temp3 AU1065301_AU1065302_jf.csv | sort -k1,1 > temp4
join -1 1 -2 1 temp4 AU1065301_AU1065303_jf.csv | sort  -k1,1 > temp5
join -1 1 -2 1 temp4 AU1065301_AU1065303_jf.csv | sort -k1,1 > temp5
join -1 1 -2 1 temp5 AU1065301_AU1065304_jf.csv | sort -k1,1 > temp6
join -1 1 -2 1 temp6 AU1348302_AU1348303_jf.csv | sort -k1,1 > temp7
join -1 1 -2 1 temp7 AU2756305_AU2756306_jf.csv | sort -k1,1 > temp8
join -1 1 -2 1 temp8 AU3199301_AU3199303_jf.csv | sort -k1,1 > temp9
sort -u -k9,9 temp9 | wc -l
