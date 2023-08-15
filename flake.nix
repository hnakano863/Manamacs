{
  description = "My emacs, that is, my golden hammer";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , emacs-overlay
    }:

    flake-utils.lib.eachDefaultSystem (system: {

      packages = let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ emacs-overlay.overlay ];
        };
      in
      rec {

        manamacs = import ./manamacs.nix { inherit pkgs; };

        default = manamacs;

      };

      devShells = rec {

        manamacs = self.packages."${system}".manamacs;

        default = self.packages."${system}".default;

      };

    });
}
