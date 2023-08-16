{
  vertico.config = ''
    (vertico-mode t)
  '';

  savehist = {
    config = ''
      (savehist-mode t)
    '';
    ensure = false;
  };

  consult.bind = {
    "C-s" = "consult-line";
  };

  orderless.custom = {
    "completion-styles" = "'(orderless basic)";
  };

  marginalia.config = ''
    (marginalia-mode t)
  '';
}
