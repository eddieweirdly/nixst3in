{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "module_blacklist=amdgpu" ];

  networking.hostName = "NixSt3in"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };


  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.drfrankenstein = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     nwg-displays
     rofi-wayland
     kitty
     file-roller
     gitFull
     refind
     hyprpanel
     yazi
     vulkan-tools
     cudaPackages.cudatoolkit
     wayvr-dashboard
     wlx-overlay-s
     xdg-desktop-portal-hyprland
     wl-clipboard



    
   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?


########## My Changes ##########

  # Download Buffer SIze
  nix.settings.download-buffer-size = 524288000;

  # Polkit
  security.polkit.enable = true;

  # GVFS
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;

  # Allow Unfree Packages
  nixpkgs.config.allowUnfree = true;

  # Enable XDG
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";

  # LightDM
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;

  # Sway
  # programs.sway.enable = true;

  # Hyperland
  programs.hyprland.enable = true;

  # Neovim
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  # Flatpak
  services.flatpak.enable = true;

  # Thunar
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [ 
  thunar-archive-plugin thunar-volman ];

  # Bluetooth
  hardware.bluetooth.enable = true;

  # ZSH
  environment.shells = with pkgs; [zsh];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # Steam
  programs.steam = {
         enable = true;
	 remotePlay.openFirewall = true;
	 protontricks.enable = true;
	 gamescopeSession.enable = true;
  };

  # Wivrn
  services.wivrn.enable = true;
  services.wivrn.openFirewall = true;
  services.wivrn.config.enable = true;
  services.wivrn.defaultRuntime = true;

  # Immersed
  # programs.immersed.enable = true;

  # Monado
  services.monado.enable = true;

  # Avahi
  services.avahi.enable = true;
  services.avahi.openFirewall = true;
  services.avahi.publish.enable = true;

  # Filesystems
  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-uuid/B658F1D258F1917B"; # Replace with your drive's UUID
    fsType = "ntfs-3g";
    options = [ "users" "nofail" ]; # Allows any user to mount; prevents boot failure if drive is not present
  };

  # Nvidia Drivers
  services.xserver.videoDrivers = ["nvidia"];
      hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

   hardware.graphics.enable = true;
   hardware.graphics.enable32Bit = true;
   
   hardware.nvidia-container-toolkit.enable = true;
   hardware.nvidia-container-toolkit.mount-nvidia-executables = true;

  # Home-Manager & Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Fonts
  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [ 
          pkgs.emojione
          pkgs.emojipick        
          pkgs.siji
          pkgs.xorg.fontmiscmisc
          pkgs.xorg.fontbhttf
          pkgs.corefonts
         # pkgs.google-fonts        
          pkgs.ucs-fonts
          pkgs.unicode-emoji
          pkgs.noto-fonts-emoji
          pkgs.open-sans
	  pkgs.nerd-fonts._3270
	  pkgs.nerd-fonts.jetbrains-mono
	  pkgs.nerd-fonts.open-dyslexic
          pkgs.nerd-fonts._3270
  ];
  
  # Virt-Manager
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["drfrankenstein"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;




}

