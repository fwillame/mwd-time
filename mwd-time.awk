#!/usr/bin/gawk -f

BEGIN{	FS="\t|\r|\n| "; OFS="\t" ; ORS="\t"

print					\
	"filename",			\
	"hole number",			\
	"hole type",			\
	"date at rockcontact",		\
	"time at rockcontact",		\
	"boom",				\
	"section number [mm]",		\
	"rig serial number",		\
	"tunnel",			\
	"start time",			\
	"hole deep [mm]",		\
	"stop time"
	}

BEGINFILE {
	numLines = 0
	while ( (getline line < FILENAME) > 0 ) {
	numLines++
	}
##		print "----\nThere are a total of", numLines, "lines in", FILENAME
}

FNR ==  1 {print "\n"FILENAME}			# filename
FNR ==  3 {print $1}				# hole number
FNR ==  5 {print $1}				# hole type
FNR ==  7 {print $1}				# date at rockcontact
FNR == 	7 {print $2}				# time at rockcontact
FNR ==  9 {print $1}				# boom
FNR == 11 {print $1}				# section number [mm]
FNR == 17 {print $1}				# rig serial number
FNR == 20 {print $1}				# tunnel
FNR == 23 {print $10}				# start time
FNR == (numLines-7) {print $1}			# hole deep (lenght of stroke) [mm]
FNR == (numLines-7) {print $10; nextfile}	# stop time
