{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    sunshine.enable =
      lib.mkEnableOption "enables sunshine nvidia game streaming module";
  };

  config = lib.mkIf config.sunshine.enable {
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true; # only needed for Wayland -- omit this when using with Xorg
      openFirewall = true;
    };

    # environment.systemPackages = with pkgs; [
    #   moonlight-qt #for testing purposes.
    # ];
  };
}
