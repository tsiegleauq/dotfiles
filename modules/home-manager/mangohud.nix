{
  config,
  lib,
  ...
}: {
  options.mangohud.enable = lib.mkEnableOption "enables Mangohud home-manager module";

  config = lib.mkIf config.mangohud.enable {
    programs.mangohud = {
      enable = true;
      settings = {
        # settings: https://raw.githubusercontent.com/flightlessmango/MangoHud/master/data/MangoHud.conf
        cpu_load_change = true;
        gpu_temp = true;
        cpu_temp = true;
        vram = true;
        ram = true;
      };
    };
  };
}
