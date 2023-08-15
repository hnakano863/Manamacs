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

  # generate use-package expression
  # confExpr :: (String -> Any -> String) -> String -> Any -> String
  confExpr = f: k: conf: if conf."${k}" == null then "" else ":${k} ${f k conf}";

  # concatAttrsWith :: (String -> Any -> String) -> Any -> String
  concatAttrsWith = f: attrs:
    let
      exprList = mapAttrsToList f attrs;
      exprList' = filter (elem: stringLength elem > 0) exprList;
    in
    concatStringsSep "\n" exprList';

  customExpr = conf:
    let
      f = k: v: "(${k} ${v} \"customized by nix\")";
      expr = k: conf': concatAttrsWith f conf'.custom;
    in confExpr expr "custom" conf;

  bindExpr = conf:
    let
      f = k: v: "(${k} . ${v})";
      expr = k: conf': "(${concatAttrsWith f conf'.bind})";
    in confExpr expr "bind" conf;

  usePackageExprFrom' = p: conf:
    let
      kwFuncMap = {

        init = getAttr;

        custom = kw: conf:
          let f = k: v: "(${k} ${v} \"customized by nix\")"; in
          concatAttrsWith f conf."${kw}";

        bind = kw: conf:
          let f = k: v: "(${k} . ${v})"; in
          "(" + (concatAttrsWith f conf."${kw}") + ")";

        config = getAttr;
      };

    in ''
      (use-package ${p}
        ${concatAttrsWith (kw: f: confExpr f kw conf) kwFuncMap})
    '';

  usePackageExprFrom = pkgConf: concatAttrsWith usePackageExprFrom' pkgConf;
}
