require_relative './src/main'

desc 'main: watch tmux panel and update ereader'
task :tmux do
  install_client
  mount_server
  watch_tmux_pane
end

task default: [:tmux]
