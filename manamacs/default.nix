{ pkgs }:

with pkgs;

let

  overrides = import ./overrides.nix;
  emacs' = (emacsPackagesFor emacs).overrideScope' overrides;

  default-el = runCommand "default.el" { src = ./default.el; } ''
    mkdir -p $out/share/emacs/site-lisp
    cp $src $out/share/emacs/site-lisp/default.el
  '';

in

emacs'.withPackages (epkgs: with epkgs; [
  default-el
  doom-modeline
  doom-themes
  evil
  use-package
])
