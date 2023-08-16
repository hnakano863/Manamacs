{ pkgs, lib, ... }:

with pkgs;
with import ./lib.nix { inherit lib; };

let

  packageConfigs = lib.attrsets.mergeAttrsList [
    (import ./modules/ui.nix)
    (import ./modules/completions.nix)
    (import ./modules/languages.nix)
  ];

  packageConfigs' = normalizePkgConf packageConfigs;

  extraPackages = epkgs:
    [ epkgs.use-package ] ++
    (collectEnsures' epkgs packageConfigs');


  default-el = epkgs: epkgs.trivialBuild {
    pname = "default";
    src = runCommand "default.el" {
      usePackageExpr = usePackageExprFrom packageConfigs';
    } ''
      substituteAll "${./default.el}" $out
    '';
    packageRequires = extraPackages epkgs;
  };

  # apply overrides
  overrides = import ./overrides.nix;
  emacs' = (emacsPackagesFor emacs).overrideScope' overrides;

in

emacs'.withPackages (epkgs: [ (default-el epkgs) ])
