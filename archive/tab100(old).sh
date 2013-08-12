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
echo "Original format:"
while read -r line; do 
	echo "$line"
done < $file

echo "New format:"

##transpose
declare -a array=( )						# we build a 1-D-array
#read -a line < $file						# read the headline
#COLS=${#line[@]}							# save number of columns

index=0
while read -a line ; do
    for (( COUNTER=0; COUNTER<${#line[@]}; COUNTER++ )); do
    	array[$index]=${line[$COUNTER]}
    	((index++))
    done
done < $file

for (( ROW = 0; ROW < COLS; ROW++ )); do
  for (( COUNTER = ROW; COUNTER < ${#array[@]}; COUNTER += COLS )); do
    printf "%s\t" ${array[$COUNTER]}
  done
  printf "\n" 
done

##enhancement 1:  auto-extract the repeat sequence 
##enhancement 2: propt for a directory, batch convert all *.100 files at once (contingent on 1)
##		might require a ls > temp.txt step (rm temp.txt)




