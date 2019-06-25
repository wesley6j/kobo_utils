def measure(label = '')
  start = Time.now.to_f
  yield
  duration = ((Time.now.to_f - start) * 1000).floor / 1000.0
  puts "\t#{label}<\e[4m #{duration}s \e[24m>"
end

def run(cmd)
  puts "\e[93m==>#{cmd}\e[0m"
  measure do
    system(cmd, out: $stdout, err: $stderr)
  end
end
