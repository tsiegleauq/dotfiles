{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    samsungprinter.enable =
      lib.mkEnableOption "enables samsungprinter module";
  };

  config = lib.mkIf config.samsungprinter.enable {
    # Enable CUPS to print documents.
    services.printing.enable = true;

    # WiFi and Network printer discovery
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    # Samsungs printer driver
    environment.systemPackages = with pkgs; [
      samsung-unified-linux-driver
    ];
  };
}
