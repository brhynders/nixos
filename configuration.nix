{ config, pkgs, ... }:

{
  # Hardware Configuration
  imports = [
    ./hardware-configuration.nix
  ];

  # Schema Version
  system.stateVersion = "24.11";

  # Boot loader
  boot.loader.systemd-boot.enable = true;  # Disable systemd-boot if you're using GRUB
  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-partlabel/EFI";  # Use partition label for EFI
    fsType = "vfat";
  };

  # Networking
  networking.networkmanager.enable = true;
  networking.hostName = "nixos"; 

  # Timezone and locale
  time.timeZone = "America/New_York"; 
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8" ];

  # Users
  users.mutableUsers = false;
  users.users.brandon = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" ];
    #hashedPassword = "your-hashed-password"; 
  };

  # Enable X server
  services.xserver.enable = true;
  services.xserver.layout = "us";

  # Enable desktop environment and window manager
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.package = pkgs.i3-gaps;

  # Set display manager (e.g., GDM, SDDM, or none if starting manually)
  services.xserver.displayManager.startx.enable = true; 

  # Packages
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    nano
    neofetch
    openssh
    alacritty        # Terminal emulator
    polybar          # Status bar for i3
    dmenu            # App launcher
    feh              # Wallpaper tool
    picom            # Compositor for transparency and shadows
    firefox          # Web browser
    htop             # System monitor
  ];

  # Enable printing and audio support
  hardware.pulseaudio.enable = true;  # Audio support
  services.printing.enable = true;    # Printing support

  # Enable the Nix command-line tool for users
  programs.nix.enable = true;

  # Firewall
  networking.firewall.enable = true;

  # NTP for time synchronization
  services.ntp.enable = true;
}
