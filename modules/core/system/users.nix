{
  config,
  ...
}: let
  user = config.hostConfig.primaryUser;
  usersecret = "users-${user}";
in {
  age.secrets.${usersecret}.file = ../../../secrets/${usersecret}.age;

  users.users.${user} = {
    uid = 1000;
    isNormalUser = true;
    description = user;
    home = "/home/${user}";
    hashedPasswordFile = config.age.secrets.${usersecret}.path;
    extraGroups = ["networkmanager" "wheel" "dialout"];
  };

  users.mutableUsers = false;
}
