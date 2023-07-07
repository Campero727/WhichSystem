#/usr/bin/env ruby
# Created By Pirata
#

class String
  def red; colorize(self, "\e[1m\e[31m"); end
  def green; colorize(self, "\e[1m\e[32m"); end
  def dark_green; colorize(self, "\e[32m"); end
  def yellow; colorize(self, "\e[1m\e[33m"); end
  def blue; colorize(self, "\e[1m\e[34m"); end
  def dark_blue; colorize(self, "\e[34m"); end
  def purple; colorize(self, "\e[35m"); end
  def dark_purple; colorize(self, "\e[1;35m"); end
  def cyan; colorize(self, "\e[1;36m"); end
  def dark_cyan; colorize(self, "\e[36m"); end
  def pure; colorize(self, "\e[0m\e[28m"); end
  def bold; colorize(self, "\e[1m"); end
  def colorize(text, color_code) "#{color_code}#{text}\e[0m" end
end

argumentos=ARGV

def extract_ip(ip)
  ipv4_regex = /(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)/

  res=ip.scan ipv4_regex

  return res.empty?
end

def get_os(ip_address)
  res_ping=""
  os=""
  IO.popen("/usr/bin/ping -c 1 #{ip_address}") do |subproceso|
    res_ping = subproceso.read
  end
  ttl=res_ping.match(/TTL=(\S+?(?:\s|t))/i)&.captures&.first
  ttl=ttl.to_i
  if ttl>=0 && ttl<=64
    os = "Linux"
  elsif ttl>=65 && ttl<=128
    os = "Windows"
  end
  puts "\n"+"*".red*50
  ip_len=ip_address.length
  puts "*".red+"#{' '*((50-(ip_len+4))/2)}Ip:".blue+"#{ip_address} #{' '*((50-(ip_len+6))/2)}".purple+"*".red
  os_len=os.length
  puts "*".red+"#{' '*((50-(os_len+4))/2)}OS:".blue+"#{os} #{' '*((50-(os_len+6))/2)}".purple+"*".red
  puts "*".red*50+"\n\n"
end

if argumentos.empty?
  program_name=File.basename(__FILE__)
  puts "\n[+]Uso: ruby".blue+" #{program_name}".purple+" <Ip Address>".blue+"\n\n"  
else
  unless extract_ip(argumentos[0]) then get_os(argumentos[0]) else puts "\n[!]".red+" Ingresa una ip valida por favor en el formato".blue+" 192.168.0.0".cyan+"\n\n" end
end


