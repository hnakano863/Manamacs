{ lib }:

with lib;

rec {

  # default package config
  defaultConf = {
    init = null;
    custom = null;
    config = null;
    bind = null;
    ensure = true;
  };

  # normalize each package's config
  normalizeConf = conf: defaultConf // conf;

  # normalize all packages' config
  normalizePkgConf = mapAttrs (p: normalizeConf);

  # collect package names which has ensure = true
  collectEnsures = pkgConf: attrNames (filterAttrs (p: c: c.ensure) pkgConf);

  # collect packages which has ensure = true
  collectEnsures' = epkgs: pkgConf: map (elem: epkgs."${elem}") (collectEnsures pkgConf);
}
