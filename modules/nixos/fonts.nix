{pkgs, ...}: {
  fonts = {
    fontDir.enable = true; # Erstellt /run/current-system/sw/share/X11/fonts
    enableDefaultPackages = true;
    packages = with pkgs; [
      fira-code
      nerd-fonts.droid-sans-mono
      dejavu_fonts
      freefont_ttf
    ];
  };
}
