# profiles/common.nix
#
# Author: João Borges <RageKnify@gmail.com>
# URL:    https://github.com/RageKnify/Config
#
# System config common across all hosts

{
  inputs,
  pkgs,
  lib,
  profiles,
  ...
}:
{
  imports = with profiles.nixos; [
    locale
    dnscrypt
    inputs.flake-programs-sqlite.nixosModules.programs-sqlite
  ];
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings.trusted-users = [
      "root"
      "@wheel"
    ];
  };

  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff /run/current-system "$systemConfig"
    '';
  };

  security.sudo.extraConfig = ''
    Defaults pwfeedback
    Defaults lecture=never
  '';

  # Every host shares the same time zone.
  time.timeZone = "Europe/Lisbon";

  services.journald.extraConfig = ''
    SystemMaxUse=500M
  '';

  users = {
    users.jp = {
      isNormalUser = true;
      hashedPassword = "$6$ISAN7cArW1aVhCSd$p3a.cLXkyl13EUKC2tSjhFRW0Wy2gTyzmdkvVVvtU1QaS14BAzS7acXOZ6xb2Baog8ur6q88FY639bKci.1Gh/";
      createHome = true;
      shell = pkgs.fish;
      extraGroups = [ "wheel" ];
      description = "João Borges";
    };
  };

  # make fish a login shell so that lightdm doesn't discriminate
  environment.shells = [ pkgs.fish ];
  # necessary for completions to work
  programs.fish.enable = true;

  # Essential packages.
  environment.systemPackages = with pkgs; [
    cached-nix-shell
    dogdns
    fd
    file
    fzf
    htop
    man-pages
    neofetch
    neovim
    procps
    ripgrep
    tmux
    unzip
    whois
    zip
    # backups
    restic
  ];

  # dedup equal pages
  hardware.ksm = {
    enable = true;
    sleep = null;
  };

  security.pki.certificateFiles = [
    (builtins.fetchurl {
      url = "https://rnl.tecnico.ulisboa.pt/ca/cacert/cacert.pem";
      sha256 = "1jiqx6s86hlmpp8k2172ki6b2ayhr1hyr5g2d5vzs41rnva8bl63";
    })
  ];

  environment.etc."ssl/certs/tecnico-ca.pem".source = (
    builtins.fetchurl {
      url = "https://si.tecnico.ulisboa.pt/configuracoes/cacert.crt";
      sha256 = "1yj2liyccwg6srxjzxfbk67wmkqdwxcx78khfi64ds8rgvs3n6hp";
    }
  );

  boot.tmp.cleanOnBoot = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = lib.mkDefault "21.11";
}
