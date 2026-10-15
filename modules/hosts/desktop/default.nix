{}
#{inputs, ...}: {
#  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
#    system = "x86_64-linux";
#    modules = [
#      inputs.self.modules.nixos.hostDesktop
#    ];
#  };

  #hostConfig = {
 #   monitors = [
 #     {
 #       output = "desc:Dell Inc. DELL S2721QS DVG9M43";
 #       mode = "highres";
 #       position = "1920x0";
 #       scale = 1.875;
 #     }
 #     {
 #       output = "desc:Ancor Communications Inc VG248 H4LMQS170852";
 #       mode = "preferred";
 #       position = "0x0";
 #       scale = 1;
 #     }
 #     {
 #       output = "desc:Hewlett Packard LA2205 3CQ9461SLN";
 #       mode = "preferred";
 #       position = "3968x0";
 #       scale = 1;
 #       transform = 1;
 #     }
 #   ];
  #};

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #system.stateVersion = "23.05";
#}
