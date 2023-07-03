# modules/home/shell/git.nix
#
# Author: João Borges <RageKnify@gmail.com>
# URL:    https://github.com/RageKnify/Config
#
# Git configuration. (Based on RiscadoA's)

{ pkgs, lib, options, config, ... }:
let
  inherit (lib) mkDefault mkOption mkEnableOption mkIf types generators;
  cfg = config.modules.shell.git;
  signers = builtins.toFile "signers" ''
    RageKnify@gmail.com,joao.p.l.borges@tecnico.ulisboa.pt,joao.borges@rnl.tecnico.ulisboa.pt ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC2sdJFvvnEIYztPcznXvKpY4vOWedZ1qzDaAgRxrczS jp@war
  '';
in {
  options.modules.shell.git = {
    enable = mkEnableOption "git";

    aliases = options.programs.git.aliases;
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      delta = {
        enable = true;
        options = { light = true; };
      };
      extraConfig = {
        diff.tool = "vimdiff";
        init.defaultBranch = "main";
        pull.rebase = true;
        url."git@github.com".pushinsteadOf = "https://github.com/";
        commit = {
          template = "${pkgs.writeText "gitmessage.txt"
            (builtins.readFile ./gitmessage.txt)}";
          verbose = true;
          gpgSign = true;
        };
        gpg.format = "ssh";
        gpg.ssh.allowedSignersFile = signers;
        user.signingKey = "~/.ssh/id_ed25519";
      };
      includes = [
        {
          condition = "gitdir:~/dev/github/";
          contents.user = {
            name = "RageKnify";
            email = "RageKnify@gmail.com";
          };
        }
        {
          condition = "gitdir:~/dev/gitlab.rnl/";
          contents.user = {
            name = "João Borges";
            email = "joao.p.l.borges@tecnico.ulisboa.pt";
          };
        }
        {
          condition = "gitdir:~/dev/ark/";
          contents.user = {
            name = "João Borges";
            email = "joao.borges@rnl.tecnico.ulisboa.pt";
          };
        }
      ];
      aliases = cfg.aliases;
    };
  };
}
