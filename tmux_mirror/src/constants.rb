HANDLER_PATH = '/adds/kbmenu/rmc/cgi-bin/displayimage.sh'.freeze
HANDLER_URL  = 'http://192.168.2.101:8087/cgi-bin/displayimage.sh'.freeze
SCREENSHOT   = '/tmp/reader/screen.png'.freeze
CONVERT      = '-rotate 270 -colorspace Gray -depth 8'.freeze
DEVICE       = 'kobo'.freeze
WINDOW_ID    = `osascript -e 'tell app "Terminal" to id of window 1'`.chomp
