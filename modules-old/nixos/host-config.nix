{ lib, config, host, ... }:

let
  inherit (lib) mkOption types;
in
{
  options.hostConfig = {
    system = mkOption {
      type = types.str;
      description = "System architecture";
    };

    impermanent = mkOption {
      type = types.bool;
      default = false;
      description = "Whether this host uses impermanence";
    };

    users = mkOption {
      type = types.listOf types.str;
      description = "User accounts for this host - the first user is considered the primary user";
    };

    primaryUser = mkOption {
      type = types.str;
      default = lib.head host.users;
      description = "Primary user account for this host";
    };

    name = mkOption {
      type = types.str;
      description = "Machine hostname";
    };

    isLaptop = mkOption {
      type = types.bool;
      default = false;
      description = "Whether this host is a laptop";
    };
  };

  config.hostConfig = host;

  config.assertions = [
    {
      assertion = config.hostConfig.users != [];
      message = "host.users must contain at least one user";
    }
    {
      assertion = lib.elem config.hostConfig.primaryUser config.hostConfig.users;
      message = "host.primaryUser (${config.hostConfig.primaryUser}) must be in host.users (${toString config.hostConfig.users})";
    }
  ];
}
