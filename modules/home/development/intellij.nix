{ pkgs, ... }: {
  home = {
    packages = with pkgs.stable; [
      jetbrains.idea-community
    ];
  };
}
