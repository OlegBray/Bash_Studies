#! /bin/bash

count=0
i=0

while [ $i -le 1000 ]
do
	if (( $i % 3 == 0 || $i % 5 == 0 )); then
		count=$((count + i))
	fi

	i=$((i + 1))
done

echo $count

