{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # ============================================================================
  # 1. SYSTEM IDENTITY & MODULE TOGGLES
  # ============================================================================
  networking.hostName = "nixos-main";
  system.stateVersion = "23.11";

  # Custom local module toggles
  gnome.enable = true;
  samsungprinter.enable = true;
  steam.enable = true;
  zshos.enable = true;
  nh.enable = true;

  # ============================================================================
  # 2. BOOT, KERNEL & HARDWARE CONFIGURATION
  # ============================================================================
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Kernel Tweaks for ath9k Wi-Fi & IOMMU pass-through
    kernelParams = ["iommu=pt"];
    extraModprobeConfig = ''
      options ath9k blink=0 btcoex_enable=1 nohwcrypt=1
    '';

    # Support standard filesystems natively
    supportedFilesystems = ["ntfs"];

    # Automate unlocking secondary LUKS drives with your keyfile in initrd
    initrd = {
      secrets = {
        "/root/mykeyfile.key" = "/root/mykeyfile.key";
      };
      luks.devices = {
        "store1".keyFile = "/root/mykeyfile.key";
        "games".keyFile = "/root/mykeyfile.key";
        "store_encrypted".keyFile = "/root/mykeyfile.key";
      };
    };
  };

  # Hardware firmware and monitoring drivers
  hardware = {
    enableRedistributableFirmware = true;
    rasdaemon.enable = true;
  };

  # ============================================================================
  # 3. FILESYSTEMS & STORAGE OPTIMIZATIONS
  # ============================================================================
  # Mount options for primary root and secondary mapped storage
  fileSystems."/".options = ["noatime"];
  fileSystems."/media/store".options = ["nofail"];
  fileSystems."/media/games".options = ["nofail"];
  fileSystems."/media/games_encrypted".options = ["nofail"];

  # Enable weekly TRIM for SSD health and performance (avoids synchronous discard lag)
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  # ============================================================================
  # 4. NETWORKING
  # ============================================================================
  networking = {
    networkmanager.enable = true;
    extraHosts = ''
      192.168.0.26 omv
      192.168.0.128 moode
    '';
    wireless.extraConfig = ''
      country=DE
    '';
  };

  # ============================================================================
  # 5. SYSTEM SERVICES & DISPLAY SERVER
  # ============================================================================
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "altgr-intl";
      };
      videoDrivers = ["amdgpu"];
    };

    # Set Wi-Fi regulatory domain on device add via udev
    udev.extraRules = ''
      SUBSYSTEM=="net", ACTION=="add", NAME=="wlan*", RUN+="${pkgs.iw}/bin/iw reg set DE"
    '';
  };

  # ============================================================================
  # 6. USERS & ACCOUNTS
  # ============================================================================
  users.users.sean = {
    isNormalUser = true;
    description = "sean";
    extraGroups = ["users" "networkmanager" "wheel" "scanner" "lp"];
  };

  # ============================================================================
  # 7. SYSTEM PROGRAMS & ENVIRONMENT
  # ============================================================================
  programs = {
    # Modern, reliable AppImage execution support
    appimage = {
      enable = true;
      binfmt = true;
    };

    # Dynamic linker support for unpackaged/standalone binaries
    nix-ld.enable = true;

    # German identity card app support
    ausweisapp = {
      enable = true;
      openFirewall = true;
    };
  };

  # Core system-wide software packages
  environment.systemPackages = with pkgs; [
    xournalpp
  ];

  # ============================================================================
  # 8. NIX PACKAGE MANAGER SETTINGS
  # ============================================================================
  nixpkgs.config = {
    allowUnfree = true;
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    # Disabled inline auto-optimise to prevent rebuilding/downloading bottlenecks.
    # Store optimization should be run periodically (via `nh clean`).
    auto-optimise-store = false;
  };

  # ============================================================================
  # 9. THEMING
  # ============================================================================
  catppuccin = {
    enable = true;
    autoEnable = true;

    flavor = "mocha";
    accent = "mauve";

    # Use pre-compiled whiskers from nixpkgs to avoid building from source
    sources = inputs.catppuccin.packages.${pkgs.stdenv.hostPlatform.system}.overrideScope (_: _: {
      whiskers = pkgs.catppuccin-whiskers;
    });

    cache.enable = true;
  };
}
