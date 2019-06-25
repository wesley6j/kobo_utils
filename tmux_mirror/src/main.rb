require_relative './constants'
require_relative './helpers'

def watch_tmux_pane
  state = ''
  loop do
    current = `tmux capturep -t 0 -p`
    if current != state
      send_image
      state = current
    else
      sleep 0.1
    end
  end
end

def install_client
  run "scp ./src/client_cgi.sh #{DEVICE}:#{HANDLER_PATH}"
  run "ssh #{DEVICE} 'chmod 777 #{HANDLER_PATH}'"
end

def mount_server
  pid = spawn('cd ./assets && php -S 0.0.0.0:9999')
  Process.detach(pid)
end

def send_image
  measure('Total:') do
    run "screencapture -o -l#{WINDOW_ID} #{SCREENSHOT}"
    run "convert #{SCREENSHOT} #{CONVERT} #{SCREENSHOT}"
    run "curl #{HANDLER_URL}"
  end
end
