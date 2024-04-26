{
  lib,
  config,
  ...
}: {
  options.ssh-client.enable = lib.mkEnableOption "enables ssh-client home manager module";

  config = lib.mkIf config.ssh-client.enable {
    programs.ssh = {
      enable = true;
      # addKeysToAgent = "yes";
    };
  };
}
