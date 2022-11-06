if [ "$XDG_SESSION_TYPE" = 'wayland' ]; then
	WINDOW_PID="$(swaymsg -t get_tree | \
		jq '.. | (.nodes? // empty)[] | select(.focused == true).pid? // empty')"
else
	WINDOW_PID="$(xdo pid)"
fi

[ -n "$WINDOW_PID" ] && TERM_PID="$(pgrep -oP $WINDOW_PID)"
[ -n "$TERM_PID" ] && WD="$(readlink -e /proc/$TERM_PID/cwd)"
! [ -n "$WD" ] && WD="$HOME"

/usr/bin/alacritty --working-directory "$WD"
