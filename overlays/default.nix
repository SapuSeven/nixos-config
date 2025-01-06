# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    catppuccin = prev.catppuccin.overrideAttrs (old: rec {
      patches =
        (old.patches or [])
        ++ [
          ./patches/catppuccin-gtk-dark-fix.diff
        ];
    });

    # https://github.com/NixOS/nixpkgs/issues/367926
    # Can be deleted after https://nixpk.gs/pr-tracker.html?pr=368470 is merged
    #    dmraid = prev.dmraid.overrideAttrs (oA: {
    #      patches = oA.patches ++ [
    #        (prev.fetchpatch2 {
    #          url = "https://raw.githubusercontent.com/NixOS/nixpkgs/f298cd74e67a841289fd0f10ef4ee85cfbbc4133/pkgs/os-specific/linux/dmraid/fix-dmevent_tool.patch";
    #          hash = "sha256-MmAzpdM3UNRdOk66CnBxVGgbJTzJK43E8EVBfuCFppc=";
    #        })
    #      ];
    #    });

    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };

  # When applied, the stable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.stable'
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
