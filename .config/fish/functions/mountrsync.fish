# Defined in /home/phil/.config/fish/config.fish @ line 50
function mountrsync
  sshfs -o cache=yes -o kernel_cache -o cache_timeout=86400 -o auto_cache -o reconnect 3610@prio.usw-s003.rsync.net:/data2/home/3610 /home/phil/rsync -C
end
