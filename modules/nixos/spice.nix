{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    spice.enable =
      lib.mkEnableOption "enables spice vm module";
  };

  config = lib.mkIf config.spice.enable {
    # services.xserver.videoDrivers = ["qxl"];
    # services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true;

    # from https://www.reddit.com/r/NixOS/comments/yv0nge/spicevdagent_is_broken_on_unstable/
    # systemd.user.services.spice-agent = {
    #   enable = true;
    #   wantedBy = ["graphical-session.target"];
    #   serviceConfig = {ExecStart = "${pkgs.spice-vdagent}/bin/spice-vdagent -x";};
    #   unitConfig = {
    #     ConditionVirtualization = "vm";
    #     Description = "Spice guest session agent";
    #     After = ["graphical-session-pre.target"];
    #     PartOf = ["graphical-session.target"];
    #   };
    # };
  };
}
