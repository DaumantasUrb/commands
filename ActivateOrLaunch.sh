#Open active google-chrome window or open chrome
#todo change "sleep 0.3" to "wait till window is active"
process=${1}
if [ $process = "phpstorm" ]; then
   process="java"
fi

pid=$(pgrep $process | head -n 1)

if [ -z "$pid" ]
then
   if [ $1 = "chrome" ]; then
      google-chrome ${2} &
      sleep 0.3s
      xdotool key "alt+d"
      exit 1
   fi
   
   $1 &
   exit 1
fi

wid=$(xdotool search --onlyvisible --pid $pid 2>/dev/null | head -n 1)
if [ -z "$wid" ]; then
   exit 2
fi

echo "window $wid"

xdotool windowactivate $wid
if [ $1 = "chrome" ]; then
   sleep 0.3s
   xdotool key "alt+d" --window $wid
fi
exit 3

