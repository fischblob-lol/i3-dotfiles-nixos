{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nvidia.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; 

  hardware.opengl.enable = true;
hardware.opengl.driSupport32Bit = true;
hardware.opengl.extraPackages = with pkgs; [ mesa.drivers ];
hardware.opengl.extraPackages32 = with pkgs; [ pkgsi686Linux.mesa.drivers ];

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";
  
  services.flatpak.enable = true;

  i18n.defaultLocale = "de_DE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.xserver.enable = true;
  
  # flakes n shit bla bla bla
  nix.settings.experimental-features = [ "nix-command" "flakes" ];   

  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };
  
    services.xserver = {
    windowManager.i3.enable = true;
  };
  services.displayManager = {
    defaultSession = "none+i3";
  };

  console.keyMap = "de";

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };
  hardware.graphics.enable = true;  

  users.users.tsd = {
    isNormalUser = true;
    description = "TSD";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [
	evolution
    ];
  };

virtualisation.libvirtd.enable = true;

virtualisation.spiceUSBRedirection.enable = true;

programs.virt-manager.enable = true;

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [
      wget
      gnomeExtensions.arcmenu
      git
      alacritty
      pulseaudio
      vscodium
      pavucontrol
      papirus-icon-theme
      fastfetch
      ipfetch
      neofetch
      prismlauncher
      cava
      gnome-software
      jetbrains.pycharm-oss
      kdePackages.konsole
      vesktop
      cmatrix
      unimatrix
      steam
      cowsay
      pipes
      unimatrix
      gnome-software
      neovim
      busybox
      gcc # systemd gcc virus backdoor lib resolv.conf
      tree-sitter
      meson
      ninja
      pkg-config
      gnome-tweaks
  ];
  system.stateVersion = "25.11";
}
