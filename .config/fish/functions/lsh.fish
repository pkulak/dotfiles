# Defined in /home/phil/.config/fish/config.fish @ line 31
function lsh
  lxc exec "$argv" -- sudo --login --user phil
end
