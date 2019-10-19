#!/usr/bin/gawk -f

function get_date (timestamp) {
	if (match(timestamp, /(....)\/(..)\/(..) (..):(..):(..)/, m)){
		t = mktime(m[1] " " m[2] " " m[3] " " m[4] " " m[5] " " m[6])}
		else { t  = mktime("1978 04 08 11 45 00") }
	return strftime("%F", t)
	}

function get_time (timestamp) {
	if (match(timestamp, /(....)\/(..)\/(..) (..):(..):(..)/, m)){
		t = mktime(m[1] " " m[2] " " m[3] " " m[4] " " m[5] " " m[6])}
		else { t  = mktime("1978 04 08 11 45 00") }
	return strftime("%T", t)
	}

BEGIN{	FS="\t|\r|\n";
	# "[ \t\n]+";
	# FS="\t|\r|\n|[[:space:]]+";\
       	OFS="\t"; ORS="\t";
	#RS="\r\n";

print					\
	"filename",			\
	"hole number",			\
	"hole type",			\
	"date at rockcontact",		\
	"time at rockcontact",		\
	"boom",				\
	"section number [mm]",		\
	"rig serial number",		\
	"RCS",				\
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

FNR ==  1 {print "\n" FILENAME}			# filename
FNR ==  3 {print $1}				# hole number
FNR ==  5 {print $1}				# hole type
FNR ==  7 {print get_date($0)}			# date at rockcontact (as YYYY-MM-DD)
FNR ==  7 {print get_time($0)}			# time at rockcontact
FNR ==  9 {print $1}				# boom
FNR == 11 {print $1}				# section number [mm]
FNR == 17 {print $1}				# rig serial number
FNR == 18 {print $1}				# RCS
FNR == 20 {print $1}				# tunnel
FNR == 23 {print $10}				# start time
FNR == (numLines-7) {print $1}			# hole deep (lenght of stroke) [mm]
FNR == (numLines-7) {print $10; nextfile}	# stop time
