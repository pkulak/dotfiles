function usage
  sudo mkdir -p /mnt/tmp
  sudo mount /dev/mapper/cryptroot -o subvol=/,subvolid=5 /mnt/tmp/
  sudo btdu /mnt/tmp
end
