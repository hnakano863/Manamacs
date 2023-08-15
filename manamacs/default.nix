{ pkgs }:

with pkgs;

emacs.withPackages (epkgs: with epkgs; [
  evil
  use-package
])
