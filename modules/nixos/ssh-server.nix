{
  lib,
  config,
  ...
}: {
  options.ssh-server.enable = lib.mkEnableOption "enables ssh-server module";

  config = lib.mkIf config.ssh-server.enable {
    services.openssh = {
      enable = true;
      ports = [22];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };
    };

    environment.systemPackages = with pkgs; [
      moonlight-qt
    ];
  };
}
