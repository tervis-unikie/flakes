# SPDX-License-Identifier: MIT
{
  lib,
  inputs,
  nixpkgs,
  user,
  ...
}: let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in {
  tervis-servu = lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs user;};
    modules = [
      ./tervis-servu/hardware-configuration.nix
      ./tervis-servu/configuration.nix
    ];
  };
  tervis-x1 = lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs user;};
    modules = [
      ./tervis-x1/hardware-configuration.nix
      ./tervis-x1/configuration.nix
    ];
  };
}
