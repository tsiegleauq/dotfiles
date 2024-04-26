{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    xclip
    # mnamer # broken
    bitwarden
    eza
    ffmpeg
    libnotify
    rsync
    # etcher # removed from nixOS since it uses an outdated version of electron. https://github.com/NixOS/nixpkgs/issues/277911
  ];
}
