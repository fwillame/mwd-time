#!/usr/bin/gawk -f

function get_date (timestamp) {
	t = mktime(gensub(/[\/:]/," ","g",timestamp))	
	return strftime("%F", t)
	}

function get_time (timestamp) {
	t = mktime(gensub(/[\/:]/," ","g",timestamp))
	return strftime("%T", t)
	}

function get_type (path,i) {
	split(path,a,"/");
	return a[i]
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
	"stop time",			\
	"project_id",			\
	"tunnel_id",			\
	"type of drilling",		\
	"section number [m]"		\
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
FNR == (numLines-7) {print $10}			# stop time
FNR == (numLines) {print get_type(FILENAME,1), get_type(FILENAME,2), get_type(FILENAME,3), get_type(FILENAME,4); nextfile}
