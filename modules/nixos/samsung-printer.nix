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
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        samsung-unified-linux-driver
      ];
    };

    # enable document scanning with SANE
    hardware.sane = {
      enable = true;
      extraBackends = with pkgs; [sane-airscan];
      disabledDefaultBackends = ["escl"];
    };
    # services.ipp-usb.enable = true;

    # WiFi and Network printer discovery
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
