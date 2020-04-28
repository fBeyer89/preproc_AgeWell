## Get acquisition time points

rm -rf test.txt

for elem in `ls -d /data/p_02030/*/*SKYRA*`
do

echo ${elem}
echo ${elem} | cut -d"/" -f4 >> IDs.txt
echo ${elem} | cut -d"_" -f3 >> time.txt


done
