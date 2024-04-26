{
  config,
  lib,
  ...
}: {
  options.chromium.enable = lib.mkEnableOption "enables chromium home-manager module";

  config = lib.mkIf config.chromium.enable {
    programs.chromium = {
      enable = true;
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
        "fnaicdffflnofjppbagibeoednhnbjhg" # floccus bookmark sync
        "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy Badger
        "lmjnegcaeklhafolokijcfjliaokphfk" # Video Download Helper
        # "efjgjleilhflffpbnkaofpmdnajdpepi" # uGet integration
        #"dhdgffkkebhmkfjojejmpbldmpobfkfo" # Tapermonkey
      ];
    };
  };
}
