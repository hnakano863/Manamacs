{ pkgs }:

with pkgs;

let

  overrides = import ./overrides.nix;
  emacs' = (emacsPackagesFor emacs).overrideScope' overrides;

  extraPackages = epkgs: with epkgs; [
    consult
    doom-modeline
    doom-themes
    evil
    orderless
    use-package
    vertico
  ];

  default-el = epkgs: epkgs.trivialBuild {
    pname = "default";
    src = ./default.el;
    packageRequires = extraPackages epkgs;
  };

in

emacs'.withPackages (epkgs: [ (default-el epkgs) ])
