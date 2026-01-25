{inputs, config, ...}: {
  modifications = final: prev: {
    catppuccin = prev.catppuccin.overrideAttrs (old: {
      patches =
        (old.patches or [])
        ++ [
          ./patches/catppuccin-gtk-dark-fix.diff
        ];
    });
  };

  additions = final: _prev: import ../pkgs final.pkgs;

  replacements = final: _prev: let
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      inherit config;
    };
  in {
    pagmo2 = stable.pagmo2; # https://github.com/NixOS/nixpkgs/issues/480860
  };
}

