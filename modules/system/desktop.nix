{self, lib, ...}:
let
  inherit (lib) mkOption types;

  monitorType = types.submodule {
    options = {
      output = mkOption {
        type = types.str;
        description = "Output connector name or description string";
      };
      mode = mkOption {
        type = types.str;
        default = "preferred";
        description = "Resolution and refresh rate (e.g. 1920x1080@60 or highres)";
      };
      position = mkOption {
        type = types.str;
        default = "0x0";
        description = "Position in display space (e.g. 1920x0)";
      };
      scale = mkOption {
        type = types.numbers.positive;
        default = 1.0;
        description = "Display scaling factor";
      };
      transform = mkOption {
        type = types.ints.between 0 7;
        default = 0;
        description = "Display rotation / transformation";
      };
    };
  };
in {
  flake.modules.nixos.system-desktop = {
    imports = with self.modules.nixos; [
      system-cli
      #printing
    ];

    options.host = {
      monitors = mkOption {
        type = types.listOf monitorType;
        default = [ ];
        description = "List of monitors attached to this host";
      };

      isLaptop = mkOption {
        type = types.bool;
        default = false;
        description = "Whether the host is a mobile form-factor machine";
      };
    };
  };

  flake.modules.darwin.system-desktop = {
    imports = with self.modules.darwin; [
      system-cli
    ];
  };

  flake.modules.homeManager.system-desktop = {
    imports = with self.modules.homeManager; [
      system-cli
      #browser
      #office
    ];
  };
}
