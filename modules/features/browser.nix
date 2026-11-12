{ self, ... }: {
  flake.modules.homeManager.browser = {lib, ...}: {
    imports = [ self.modules.homeManager.zen ];

    options.commands.browser = {
      open = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "Command to open the browser";
      };
      private = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "Command to open a private browser window";
      };
    };
  };
}