self: super: {
  treemacs = self.melpaBuild {
    inherit (super.treemacs) pname ename commit version src recipe meta;
    packageRequires = super.treemacs.propagatedBuildInputs ++ [ self.doom-modeline ];
  };
}
