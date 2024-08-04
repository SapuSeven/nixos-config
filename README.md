Great template for splitting up the config:
https://github.com/Frost-Phoenix/nixos-config

More inspiration:
https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles
-> cool volume change popup

## Update packages

```
nix flake lock --update-input nixpkgs
```

## TODO
- Modularize main config
- Display dim and timeout (extra short when locked) including idle inhibitor
- Brightness control waybar
