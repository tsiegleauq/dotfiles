{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    cryptsetup
    git
    htop
    wget
    vim
  ];
}
