psg () {
	if [ -z "$1" ]
	then echo "You must supply a grep pattern."
	else
		ps awux | head  -1
		ps awux | grep -E "$1" | grep -Ev "grep -E $1"
	fi
}

psgi () {
	if [ -z "$1" ]
	then echo "You must supply a grep pattern."
	else
		ps awux | head  -1
		ps awux | grep -Ei "$1" | grep -Evi "grep -Ei $1"
	fi
}

f () {
	if [ -z "$1" ]
	then echo "You must supply a glob pattern."
	else
		find . -name "$1" -print
	fi
}

# alias fs  'find . -name \!:1 -exec \!:2 {} \!:3-$ \;'
fs () {
	if [ -z "$1" ]
	then echo "You must supply a glob pattern."
	elif [ -z "$2" ]
	then echo "You must supply a command to perform on each found file."
	elif [ -z "$3" ]
	then echo "You really should supply an argument for the command \"$2\"."
	else
		globpattern=$1
		shift
		command=$1
		shift
		find . -name "$globpattern" -exec "$command" {} "$@" \;
	fi
}

# alias fe  'find . -name \!:1 -exec \!:2-$ {} \;'
fe () {
	if [ -z "$1" ]
	then echo "You must supply a glob pattern."
	elif [ -z "$2" ]
	then echo "You must supply a command to perform on each found file."
	else
		globpattern=$1
		shift
		find . -name "$globpattern" -exec "$@" {} \;
	fi
}

nforf () {
	if [ ${#@} -lt 3 ]
	then
		echo "Usage: nforf file [file ...] -- command [arg ...]"
		return 1
	fi

	echo "$*" | grep -q -- ' -- '
	if [ $? -eq 1 ]
	then
		echo "Usage: nforf file [file ...] -- command [arg ...]"
		return 2
	fi

	filelist=`echo "$*" | sed 's/ -- .*//'`
	command=`echo "$*" | sed 's/.* -- //'`

	for file in $filelist
	do
		encfile=`echo $file | sed 's/\//\\\\\//g'`
		excommand=`echo $command | sed -e "s/%/$encfile/g"`
		$excommand
	done
}

forf () {
	if [ ${#@} -lt 3 ]
	then
		echo "Usage: forf file [file ...] -- command [arg ...]"
		return 1
	fi

	echo "$*" | grep -q -- ' -- '
	if [ $? -eq 1 ]
	then
		echo "Usage: forf file [file ...] -- command [arg ...]"
		return 2
	fi

	filelist=`echo "$*" | sed 's/ -- .*//'`
	command=`echo "$*" | sed 's/.* -- //'`

	for file in $filelist
	do
		oldfile=$file.0
		mv $file $oldfile && $command $oldfile > $file 
	done
}

unforf () {
	if [ -z "$1" ]
	then echo "No files specified."
	else
		for file in $@
		do
			origfile=$file.0
			if [ -e $origfile ]
			then
				mv $origfile $file
			fi
		done
	fi
}

# cd up $1 directories
cdc () {
	if [ -z "$1" ]
	then return 1
	fi

	declare -i count
	count=$1
	while [ $count -gt 0 ]
	do
		cd ..
		count=`expr $count-1`
	done
}

ces () {
	if [ ${#@} -lt 2 ]
	then
		echo "Usage: ces [delay] [commands ...]"
		return 1
	fi

	delay="$1"
	shift

	command="$*"


	while true
	do
		clear
		$command
		sleep $delay
	done
}

# Go to a symlinked directory in the ~/.to directory.
to () {
  if [ -z "$1" ]
	then echo "You must supply a glob pattern."
	else
    cd /home/cgoldman/.to/$1
  fi
}

#  for f in .; do n=`find $f -type f | wc -l`; echo "$n $f"; done | sort -n

e () {
    emacsclient "$@" 2> /dev/null &
}

show-profile () {
    if [ -z "$1" ]
    then >&2 echo "You must specify a .ipa file."
    fi
}
