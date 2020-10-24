#!/bin/bash

SCRIPT=$1.sh
echo $SCRIPT
while [[  -e $SCRIPT ]]
do
	echo -n "File already exists, Overwrite? (y/n):"
	read FLAG
	case $FLAG in
		 y|Y|[Yy][eE][Ss])
			break
			;;
		n|N|[Nn][Oo])
			read -p "Enter new filename:" SCRIPT
			SCRIPT=$SCRIPT.sh
			;;
	esac
done

echo "#!/bin/bash" > $SCRIPT
chmod u=rwx $SCRIPT
nano $SCRIPT
