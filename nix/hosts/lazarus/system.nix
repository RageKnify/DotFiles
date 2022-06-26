# hosts/lazarus/system.nix
#
# Author: João Borges <RageKnify@gmail.com>
# URL:    https://github.com/RageKnify/Config
#
# System configuration.

{ pkgs, lib, sshKeys, ... }: {

  boot.cleanTmpDir = true;
  networking.domain = "jplborges.pt";
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    authorizedKeysFiles = lib.mkForce [ "/etc/ssh/authorized_keys.d/%u" ];
    kbdInteractiveAuthentication = false;
  };

  users = {
    mutableUsers = true;
    users = {
      jp.openssh.authorizedKeys.keys = sshKeys;
    };
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  environment.systemPackages = with pkgs; [
    (let
      extra-packages = python-packages: with python-packages; [
        docker
        # other python packages you want
      ];
      pythonWithStuf = python3.withPackages extra-packages;
    in
    pythonWithStuf
    )
  ];
}
