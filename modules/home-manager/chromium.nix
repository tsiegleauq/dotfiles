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
        # Wip
        # {
        # iamadamdev/bypass-paywalls-chrome
        # id = "dcpihecpambacapedldabdbpakmachpb";
        # updateUrl = "https://raw.githubusercontent.com/iamadamdev/bypass-paywalls-chrome/master/updates.xml";
        # }
        # "efjgjleilhflffpbnkaofpmdnajdpepi" # uGet integration
        #"dhdgffkkebhmkfjojejmpbldmpobfkfo" # Tapermonkey
        # {
        #old version
        # id = "dcpihecpambacapedldabdbpakmachpb";
        # updateUrl = "https://raw.githubusercontent.com/iamadamdev/bypass-paywalls-chrome/master/updates.xml";
        # updateUrl = "https://raw.githubusercontent.com/iamadamdev/bypass-paywalls-chrome/master/manifest.json";

        # bypass paywall chrome
        # Github: https://github.com/bpc-clone/bypass-paywalls-chrome-clean
        # id = "lkbebcjgcmobigpeffafkodonchffocl";
        # crxPath = "https://github.com/bpc-clone/bypass-paywalls-chrome-clean/releases/download/latest/bypass-paywalls-chrome-clean-3.6.6.0.crx";
        # }
      ];
    };
  };
}
