#!/bin/bash

#when set to exit, mpd_control will exit if you press escape
#when set to break, mpd_control will go the upper level if possible
ESC_ACTION="break"
# source configuration file for rofi if exists

ROFI="rofi -dmenu -p 'Search:'"

addaftercurrent(){
	
	#playlist is empty, just add the song
	if [ "$(mpc -p 6601 playlist | wc -l)" == "0" ]; then
		mpc -p 6601 add "$1" 

	#there is no current song so mpd is stopped
	#it seems to be impossible to determine the current songs' position when 
	#mpd is stopped, so just add to the end
	elif [ -z "$(mpc -p 6601 current)" ]; then 
		mpc -p 6601 play
		CUR_POS=$(mpc -p 6601  | tail -2 | head -1 | awk '{print $2}' | sed 's/#//' | awk -F/ '{print $1}')
		END_POS=$(mpc -p 6601 playlist | wc -l)
		mpc -p 6601 add "$1"
		mpc -p 6601 move $(($END_POS+1)) $(($CUR_POS+1))	
		mpc -p 6601 stop

	#at least 1 song is in the playlist, determine the position of the 
	#currently played song and add $1 after it
	else

		CUR_POS=$(mpc -p 6601  | tail -2 | head -1 | awk '{print $2}' | sed 's/#//' | awk -F/ '{print $1}')
		END_POS=$(mpc -p 6601 playlist | wc -l)
		mpc -p 6601 add "$1"
		mpc -p 6601 move $(($END_POS+1)) $(($CUR_POS+1))	
	fi
}
addaftercurrentandplay(){

	#playlist is empty, just add the song
	if [ "$(mpc -p 6601 playlist | wc -l)" == "0" ]; then
		mpc -p 6601 add "$1" 
		mpc -p 6601 play

	#there is no current song so mpd is stopped
	#it seems to be impossible to determine the current songs' position when 
	#mpd is stopped, so just add to the end
	elif [ -z "$(mpc -p 6601 current)" ]; then 
		mpc -p 6601play
		CUR_POS=$(mpc -p 6601  | tail -2 | head -1 | awk '{print $2}' | sed 's/#//' | awk -F/ '{print $1}')
		END_POS=$(mpc -p 6601 playlist | wc -l)
		mpc -p 6601 add "$1"
		mpc -p 6601 move $(($END_POS+1)) $(($CUR_POS+1))	
		mpc -p 6601 play $(($CUR_POS+1))

	#at least 1 song is in the playlist, determine the position of the 
	#currently played song and add $1 after it
	else

		CUR_POS=$(mpc -p 6601 | tail -2 | head -1 | awk '{print $2}' | sed 's/#//' | awk -F/ '{print $1}')
		END_POS=$(mpc -p 6601 playlist | wc -l)
		mpc -p 6601 add "$1"
		mpc -p 6601 move $(($END_POS+1)) $(($CUR_POS+1))	
		mpc -p 6601 play $(($CUR_POS+1))
	fi
}

case $1 in
	
	-a|--artist)
	
	while true; do

		ARTIST="$(mpc -p 6601 list artist | sort -f | $ROFI)";
		if [ "$ARTIST" = "" ]; then $ESC_ACTION; fi
		
		while true; do

			ALBUMS=$(mpc -p 6601 list album artist "$ARTIST" | sort -f);
			ALBUM=$(echo -e "replace all\nadd all\n--------------------------\n$ALBUMS" | $ROFI);
			if [ "$ALBUM" = "" ]; then $ESC_ACTION;
			
			elif [ "$ALBUM" = "replace all" ]; then
				CUR_SONG=$(mpc -p 6601 current)
				mpc -p 6601 clear
				mpc -p 6601 find artist "$ARTIST" | mpc -p 6601 add 
				if [ -n "$CUR_SONG" ]; then mpc -p 6601  play; fi
				$ESC_ACTION
			elif [ "$ALBUM" = "add all" ]; then 
				mpc -p 6601 find artist "$ARTIST" | mpc -p 6601 add
				$ESC_ACTION
			fi
			
			while true; do
				
				TITLES=$(mpc -p 6601 list title artist "$ARTIST" album "$ALBUM")
				TITLE=$(echo -e "replace all\nadd all\n--------------------------\n$TITLES" | $ROFI);
				if [ "$TITLE" = "" ]; then $ESC_ACTION
				elif [ "$TITLE" = "replace all" ]; then
					CUR_SONG=$(mpc -p 6601 current)
					mpc -p 6601 clear;
					mpc -p 6601 find artist "$ARTIST" album "$ALBUM" | mpc -p 6601 add 
					if [ -n "$CUR_SONG" ]; then mpc -p 6601 play; fi
					$ESC_ACTION
				elif [ "$TITLE" = "add all" ]; then
					mpc -p 6601 find artist "$ARTIST" album "$ALBUM" | mpc -p 6601 add 
					$ESC_ACTION
				
				fi

				while true; do
					DEC=$(echo -e "add after current and play\nadd after current\nreplace\nadd at the end" | $ROFI);
					case $DEC in 

						"")
						$ESC_ACTION
						;;

						"add after current and play")
						addaftercurrentandplay "$(mpc -p 6601 find artist "$ARTIST" album "$ALBUM" title "$TITLE" | head -1 )"
						;;

						"add after current")
						addaftercurrent "$(mpc -p 6601 find artist "$ARTIST" album "$ALBUM" title "$TITLE" | head -1 )"
						;;

						"replace")
						CUR_SONG=$(mpc -p 6601 current)
						mpc -p 6601 clear
						mpc -p 6601 find artist "$ARTIST" album "$ALBUM" title "$TITLE" | head -1 | mpc -p 6601 add
						if [ -n "$CUR_SONG" ]; then mpc -p 6601 play; fi
						;;
						
						"add at the end")
						mpc -p 6601 find artist "$ARTIST" album "$ALBUM" title "$TITLE" | head -1 | mpc -p 6601 add
						;;

					esac
					$ESC_ACTION
				done
			done
		done
	done
	;;

	-t|--track)
		
	TITLE=$(mpc -p 6601 list title | sort -f | $ROFI)
	if [ "$TITLE" = "" ]; then exit; fi
	
	SONG=$(mpc -p 6601 find title "$TITLE" | head -1) 
	addaftercurrentandplay "$SONG"
	;;

	-p|--playlist)
	PLAYLIST=$(mpc -p 6601 lsplaylists | $ROFI);
	if [ "$PLAYLIST" = "" ]; then exit; fi
	CUR_SONG=$(mpc -p 6601 current)
	mpc -p 6601 clear
	mpc -p 6601 load "$PLAYLIST";
	if [ -n "$CUR_SONG" ]; then mpc -p 6601 play; fi
	;;

	-j|--jump)
	
	TITLE=$(mpc -p 6601 playlist | $ROFI);
	if [ "$TITLE" = "" ]; then exit; fi
	POS=$(mpc -p 6601 playlist | grep -n "$TITLE" | awk -F: '{print $1}')
	mpc -p 6601 play $POS;
	;;

	-l|--longplayer)
	
	while true; do

		ALBUM=$(mpc -p 6601 list album | sort -f | $ROFI);
		if [ "$ALBUM" = "" ]; then $ESC_ACTION;
		fi
		
		while true; do
			
			TITLES=$(mpc -p 6601 list title album "$ALBUM")
			TITLE=$(echo -e "replace all\nadd all\n--------------------------\n$TITLES" | $ROFI);
			if [ "$TITLE" = "" ]; then $ESC_ACTION
			elif [ "$TITLE" = "replace all" ]; then
				CUR_SONG=$(mpc -p 6601 current)
				mpc -p 6601 clear;
				mpc -p 6601 find album "$ALBUM" | mpc -p 6601 add 
				if [ -n "$CUR_SONG" ]; then mpc -p 6601 play; fi
				$ESC_ACTION
			elif [ "$TITLE" = "add all" ]; then
				mpc -p 6601 find album "$ALBUM" | mpc -p 6601 add 
				$ESC_ACTION
			
			fi

			while true; do
				DEC=$(echo -e "add after current and play\nadd after current\nreplace\nadd at the end" | $ROFI);
				case $DEC in 

					"")
					$ESC_ACTION
					;;

					"add after current and play")
					addaftercurrentandplay "$(mpc -p 6601 find album "$ALBUM" title "$TITLE" | head -1 )"
					;;

					"add after current")
					addaftercurrent "$(mpc -p 6601 find album "$ALBUM" title "$TITLE" | head -1 )"
					;;

					"replace")
					CUR_SONG=$(mpc -p 6601 current)
					mpc -p 6601 clear
					mpc -p 6601 find album "$ALBUM" title "$TITLE" | head -1 | mpc -p 6601 add
					if [ -n "$CUR_SONG" ]; then mpc -p 6601 play; fi
					;;
					
					"add at the end")
					mpc -p 6601 find album "$ALBUM" title "$TITLE" | head -1 | mpc -p 6601 add
					;;

				esac
				$ESC_ACTION
			done
		done
	done
	;;

	-h|--help)
	echo "-a, --artist		search for artist, then album, then title"
    	echo "-t, --track		search for a single track in the whole database"
	echo "-p, --playlist		search for a playlist load it"
	echo "-j, --jump		jump to another song in the current playlist"		 
	echo "-l, --longplayer	search for album, then title"
	
	
	
	
	;;
	
	*)
	echo "Usage: rofi-mpd [OPTION]"
	echo "Try 'rofi-mpd --help' for more information."
	;;

esac
