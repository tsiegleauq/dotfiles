{
  # Common aliases
  cp = "cp -i";
  df = "df -h";
  free = "free -m";
  clip = "xclip -selection c";
  ls = "eza";
  ll = "eza --long --group --all --header";
  vim = "nvim";
  vi = "nvim";

  # nixos aliases
  nix-switch = "nh os switch";
  nix-test = "nh os test";
  nix-update = "sudo nix-channel --update";
  flake-update = "nix flake update --flake ~/.dotfiles";
  nix-cleanup = "nh clean all";
  trimssd = "sudo fstrim -av";

  # home stuff
  # some home infrastructure
  sshfspi = "sshfs pi:/ ~/sshfs";
  usbip-bindbt = "sudo usbip attach -r pi -d 1-1.5";
  ebook-convert-all = "for book in *.epub; do echo \"Converting $book\"; ebook-convert \"$book\" \"$(basename \"$book\" .epub).mobi\"; done";
  sunshine = "sunshine ~/.config/sunshine/sunshine.conf";
  rclone_mount = "systemctl --user start rclone-crypt.service";
  rclone_umount = "systemctl --user stop rclone-crypt.service";
}
