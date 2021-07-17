exec xrdb -l ~/.Xresources &
exec xrandr --output DP1 --mode 1600x900 --right-of eDP1 &
exec setxkbmap -layout gb &
exec dwm # &
#while true ; do xsetroot -name "`date '+%Y-%m-%d %H:%M.%S'` `uptime |sed 's/.*,//'`"; sleep 1 ; done &
