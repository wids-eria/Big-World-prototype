#!/bin/bash

singleton_path=`dirname $0`/spawn_a_worker.sh
echo "Going to launch from $singleton_path"

for port in {27017..27024}
do
	for i in {1..10}
	do
		$singleton_path $port
	done
done

