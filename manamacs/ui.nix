{
  evil = {
    custom = {
      "evil-want-C-u-scroll" = "t";
    };
    config = ''
      (evil-mode t)
    '';
  };

  doom-themes.config = ''
    (load-theme 'doom-opera t)
  '';

  doom-modeline.config = ''
    (doom-modeline-mode t)
  '';
}
