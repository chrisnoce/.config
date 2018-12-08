#!/bin/sh
# Add alias to .zaliases

function addalias() {
	if [[ -z $! || -z $2 || $# -gt 2 ]]; then
		echo usage:
		echo "\t\$$0 ll 'ls -l'"
	else
		echo "alias $1='$2'" >> $ALIASDB
		echo "alias ADDED to $ALIASDB"
	fi
}
