# SPDX-License-Identifier: MIT
{
  description = "declarations of machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    alejandra,
    ...
  }: let
    user = "tervis";
  in {
    nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs user;
        modules = [
          ({pkgs, ...}: {
            config = {
              nix.settings = {
                trusted-public-keys = [
                  "cache.vedenemo.dev:8NhplARANhClUSWJyLVk4WMyy1Wb4rhmWW2u8AejH9E="
                  "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                ];
                substituters = [
                  "https://cache.vedenemo.dev"
                  "https://cache.nixos.org"
                ];
              };
            };
          })
        ];
      }
    );
  };
}
