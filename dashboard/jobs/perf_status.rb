
#!/usr/bin/env ruby


SCHEDULER.every '1m', :first_in => 0 do |job|
  cpu = `grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}'`
  cpu = (cpu.to_f).round(2)
  send_event('cpu', {current: cpu})

  disk = `df / --output='pcent' | sed -n 2p`
  send_event('disk', {value: disk.delete('%').to_i})

  updates = `apt list --upgradable | wc -l`
  updates = updates.to_i - 1
  send_event('updates-available', {current: updates})

  rx0 = `cat /sys/class/net/eth0/statistics/rx_bytes`
  tx0 = `cat /sys/class/net/eth0/statistics/tx_bytes`
  sleep(1)
  rx1 = `cat /sys/class/net/eth0/statistics/rx_bytes`
  tx1 = `cat /sys/class/net/eth0/statistics/tx_bytes`
  inx = rx1.to_i - rx0.to_i
  out = tx1.to_i - tx0.to_i
  if out > 1048576
    out = out / 1024
    out = out / 1024
    out = "#{out} Mb/s"
  elsif out > 1024
    out = out / 1024
    out = "#{out} Kb/s"
  else
    out = "<1Kb/s"
  end
  if inx > 1048576
    inx = inx / 1024
    inx = inx / 1024
    inx = "#{inx} Mb/s"
  elsif inx > 1024
    inx = inx / 1024
    inx = "#{inx} Kb/s"
  else
    inx = "<1Kb/s"
  end
  send_event('network', {text: "⬆ #{out}\n⬇ #{inx}"})

  ram = `free | grep Mem | awk '{print $3/$2 * 100.0}'`
  ram = (ram.to_f).round(2)
  send_event('ram', {value: ram})

  clients = `arp | wc -l`
  clients = clients.to_i - 1
  send_event('clients', {current: clients})
end