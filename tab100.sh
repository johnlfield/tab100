#! /bin/bash


##input
echo ""
echo "This program converts list-format *.100 files into tabular format."
# echo "Please type the file path for the directory you wish to search (full pathway from root):"
# read path
# cd $path
echo "Please specify the file you wish to convert:"
read file
echo "Please specify the number of variables for each entry:"
read repeat

##print original file
# echo "Original format:"
# while read -r line; do 
# 	echo "$line"
# done < $file
# 
# echo "New format:"

## declare an array for each variable- WORKING
for ((i=1;i<=$repeat;i++)); do
#	echo "$i"
	declare -a "array$i=( )"
done
#declare -a array=( )						# build a 1-D-array
#read -a line < $file						# read the headline
#COLS=${#line[@]}							# save number of columns


# strategy:  instead of trying to crunch the entries in finite blocks, try a grep loop to split off separate event array, variable name array, big variable list
#  variables differentiated from event names based on whether they are numeric 
#  then it's just a matter of looping everything together

## split the file into subfile with headers, data
# grep -E ^[0-9]+\.?[0-9]* $file > data.txt			# keep all lines that being with a floating point
# grep -Ev ^[0-9]+\.?[0-9]* $file > head.txt			# keep all lines that DON'T begin with a floating point

## create data array
j=1
echo ""
while read -a line ; do
echo "j=$j"
    for ((e=0;e<=2;e++)); do
    	eval array$j[$e]=$(echo "$line" | cut -f 1)
#    	eval array$j[$e]=${line[$e]}		
    done
    j=$[$j+1]
    echo "j=$j"
    if [ $j -eq $repeat ]
    then
    	j=1
    fi
echo "j=$j"
for ((i=1;i<=$repeat;i++)); do
	eval echo \${array$i[@]}
done
done < $file

## print out the content of each array- WORKING
echo ""
echo "Tabular output:"
for ((i=1;i<=$repeat;i++)); do
	eval echo \${array$i[@]}
done

## print the data table
# for (( ROW = 0; ROW < COLS; ROW++ )); do
#   for (( COUNTER = ROW; COUNTER < ${#array[@]}; COUNTER += COLS )); do
#     printf "%s\t" ${array[$COUNTER]}
#   done
#   printf "\n" 
# done

## file cleanup
# rm head.txt data.txt

##enhancement 1:  auto-extract the repeat sequence 
##enhancement 2: propt for a directory, batch convert all *.100 files at once (contingent on 1)
##		might require a ls > temp.txt step (rm temp.txt)




