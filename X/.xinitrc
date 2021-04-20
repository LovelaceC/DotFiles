exec nitrogen --restore &
while true ; do xsetroot -name "`date '+%Y-%m-%d %H:%M.%S'` `uptime |sed 's/.*,//'`"; sleep 1 ; done &
exec xrdb -l ~/.Xdefaults &
exec setxkbmap -layout gb &
exec xrandr --output DP1 --mode 1600x900 --right-of eDP1 &
exec /usr/local/bin/dwm
