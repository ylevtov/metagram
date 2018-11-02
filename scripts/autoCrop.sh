#!/bin/sh

usage ()
{
    echo "usage: indir outfilename (optional)"
    echo "	indir		specify absolute path to audio files (must be WAV format)"
    echo "	outfilename	specify name for output file (name only - .wav will be added automatically)"
    exit 1
}

if [ ${#@} -gt 0 ];
	then
		cd $1
		echo $1
		if [ ! -d cropped ]; then
			mkdir cropped
		fi

		for INPUTFILE in *.jpg
		do
			NAME=${INPUTFILE%.*}
			echo $INPUTFILE
			PWD = pwd
			echo $PWD
			"sudo convert $PWD/$INPUTFILE -crop 3x3@ $PWD/cropped/"$NAME"-cropped%01d.jpg"

			# Trim silence
			# sox tmp/$NAME-l.wav tmp/$NAME-trim-l.wav silence 1 0.01 0.1% # Here is where the threshold for silence is set
			# sox tmp/$NAME-r.wav tmp/$NAME-trim-r.wav silence 1 0.01 0.1% # http://sox.sourceforge.net/sox.html (search: silence [−l])

			wait
			# Rejoin audio files
			# sox -M tmp/$NAME-trim-l.wav tmp/$NAME-trim-r.wav tmp/$NAME-trimmed.wav

			wait
			# Calculate how many samples to add back on to the end
			# TRIMMEDLENGTH=$(soxi -s tmp/$NAME-trimmed.wav)
			# Sample length of 512 is hardcoded for the moment
			# PADLENGTH=$((512-$TRIMMEDLENGTH))
			# S="s"

			# sox tmp/$NAME-trimmed.wav stripped/$NAME-stripped.wav pad 0 $PADLENGTH$S

			wait
		done

	else
		usage
fi