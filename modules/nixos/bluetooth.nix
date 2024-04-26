{
  lib,
  config,
  ...
}: {
  options.bluetooth.enable = lib.mkEnableOption "enables bluetooth module";

  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };
}
