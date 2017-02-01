#!/bin/bash

if [ ! -f .prevmediadir ]; then

	echo -n "Media directory?: "
	read mediadir
	echo $mediadir > .prevmediadir

else

	echo -n "Media directory? [RETURN to use previous dir ($(cat .prevmediadir))]: "
	read mediadir

	if [ "$mediadir" == "" ]; then
		mediadir=$(cat .prevmediadir)
	else
		echo $mediadir > .prevmediadir
	fi

fi

mediaamount=$(ls -1 $mediadir | wc -l)

while (( mediaamount > 0 )); do

	number=$RANDOM
	let "number%=$mediaamount"
	let "number+=1"

	file=$(ls -mw0 $mediadir | cut -d, -f$number | cut -d" " -f2)

	vlc $mediadir/$file
	
	if [ ! -d "$mediadir/.watched" ]; then
		mkdir $mediadir/.watched
	fi

	mv $mediadir/$file $mediadir/.watched

	mediaamount=$(ls -1 $mediadir | wc -l)

done

echo "Finished bingewatching! :)"

exit 1

