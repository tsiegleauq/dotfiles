{pkgs, ...}: {
  environment = {
    localBinInPath = true;

    variables = {
      EDITOR = "nvim";
      DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = 1;
    };

    sessionVariables.NIXOS_OZONE_WL = "1";

    systemPackages = with pkgs; [
      git
      gnumake
      htop
      wget
      zip
    ];
  };
}
